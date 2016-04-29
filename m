From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 2/9] vfio: No-IOMMU mode support
Date: Fri, 29 Apr 2016 10:21:42 -0600
Message-ID: <20160429102142.15b3ef51@t450s.home>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
	<1461932003-23830-3-git-send-email-renxiaof@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-3-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 Apr 2016 14:13:16 +0200
Xiao Feng Ren <renxiaof@linux.vnet.ibm.com> wrote:

> Add qemu support for the newly introduced VFIO No-IOMMU driver.
> 
> We need to add special handling for:
> - Group character device is /dev/vfio/noiommu-$GROUP.
> - No-IOMMU does not rely on a memory listener.
> - No IOMMU will be set for its group, so no need to call
>   vfio_kvm_device_add_group.
> 
> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> ---
>  hw/vfio/common.c              | 66 ++++++++++++++++++++++++++++++++++---------
>  include/hw/vfio/vfio-common.h |  2 ++
>  2 files changed, 55 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f27db36..656c303 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -789,6 +789,33 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as)
>      container = g_malloc0(sizeof(*container));
>      container->space = space;
>      container->fd = fd;
> +    container->noiommu = group->noiommu;
> +
> +    if (container->noiommu) {
> +        ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
> +        if (ret) {
> +            error_report("vfio: failed to set group container: %m");
> +            ret = -errno;
> +            goto free_container_exit;
> +        }
> +
> +        ret = ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_NOIOMMU_IOMMU);
> +        if (!ret) {
> +            error_report("vfio: No available IOMMU models");
> +            ret = -EINVAL;
> +            goto free_container_exit;
> +        }
> +
> +        ret = ioctl(fd, VFIO_SET_IOMMU, VFIO_NOIOMMU_IOMMU);
> +        if (ret) {
> +            error_report("vfio: failed to set iommu for container: %m");
> +            ret = -errno;
> +            goto free_container_exit;
> +        }
> +
> +        goto listener_register;
> +    }
> +
>      if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
>          ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
>          bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
> @@ -878,14 +905,16 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as)
>          goto free_container_exit;
>      }
>  
> -    container->listener = vfio_memory_listener;
> -
> -    memory_listener_register(&container->listener, container->space->as);
> -
> -    if (container->error) {
> -        ret = container->error;
> -        error_report("vfio: memory listener initialization failed for container");
> -        goto listener_release_exit;
> +listener_register:
> +    if (!container->noiommu) {
> +        container->listener = vfio_memory_listener;
> +        memory_listener_register(&container->listener, container->space->as);
> +        if (container->error) {
> +            ret = container->error;
> +            error_report("vfio: memory listener initialization failed for "
> +                         "container");
> +            goto listener_release_exit;
> +        }
>      }
>  
>      container->initialized = true;
> @@ -898,7 +927,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as)
>  
>      return 0;
>  listener_release_exit:
> -    vfio_listener_release(container);
> +    if (!container->noiommu) {
> +        vfio_listener_release(container);
> +    }
>  
>  free_container_exit:
>      g_free(container);
> @@ -928,7 +959,9 @@ static void vfio_disconnect_container(VFIOGroup *group)
>          VFIOAddressSpace *space = container->space;
>          VFIOGuestIOMMU *giommu, *tmp;
>  
> -        vfio_listener_release(container);
> +        if (!container->noiommu) {
> +            vfio_listener_release(container);
> +        }
>          QLIST_REMOVE(container, next);
>  
>          QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
> @@ -969,8 +1002,13 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as)
>      snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
>      group->fd = qemu_open(path, O_RDWR);
>      if (group->fd < 0) {
> -        error_report("vfio: error opening %s: %m", path);
> -        goto free_group_exit;
> +        snprintf(path, sizeof(path), "/dev/vfio/noiommu-%d", groupid);
> +        group->fd = qemu_open(path, O_RDWR);
> +        if (group->fd < 0) {
> +            error_report("vfio: error opening %s: %m", path);
> +            goto free_group_exit;
> +        }
> +        group->noiommu = 1;

No, this just can't happen.  There is absolutely no way that falling
back to a noiommu interface is the correct thing to do in most
situations. It cannot be automatic or I will have vfio-pci users lined
up trying to do PCI device assignment with this code.

>      }
>  
>      if (ioctl(group->fd, VFIO_GROUP_GET_STATUS, &status)) {
> @@ -999,7 +1037,9 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as)
>  
>      QLIST_INSERT_HEAD(&vfio_group_list, group, next);
>  
> -    vfio_kvm_device_add_group(group);
> +    if (!group->noiommu) {
> +        vfio_kvm_device_add_group(group);
> +    }

Why?  Notifying KVM of an assigned device doesn't necessarily imply
some connection to the IOMMU.

>  
>      return group;
>  
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index eb0e1b0..85c2a74 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -72,6 +72,7 @@ struct VFIOGroup;
>  typedef struct VFIOContainer {
>      VFIOAddressSpace *space;
>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
> +    bool noiommu;
>      MemoryListener listener;
>      int error;
>      bool initialized;
> @@ -121,6 +122,7 @@ struct VFIODeviceOps {
>  typedef struct VFIOGroup {
>      int fd;
>      int groupid;
> +    bool noiommu;
>      VFIOContainer *container;
>      QLIST_HEAD(, VFIODevice) device_list;
>      QLIST_ENTRY(VFIOGroup) next;
