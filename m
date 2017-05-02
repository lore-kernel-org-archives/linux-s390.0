From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/13] vfio/ccw: vfio based subchannel
 passthrough driver
Date: Tue, 2 May 2017 08:48:38 +0200
Message-ID: <56f3a0e3-386e-ede0-e628-e6448182a333@redhat.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
 <20170428130951.44771-8-bjsdjshi@linux.vnet.ibm.com>
 <3958d3c4-2381-dc97-47cf-9a72593cd83c@redhat.com>
 <20170502050753.GC27968@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170502050753.GC27968@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, cornelia.huck@de.ibm.com, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dong,

On 02/05/2017 07:07, Dong Jia Shi wrote:
> * Auger Eric <eric.auger@redhat.com> [2017-05-01 13:08:05 +0200]:
> 
> Hi Eric,
> 
> [...]
> 
>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>> new file mode 100644
>>> index 0000000..cd4dfe8
>>> --- /dev/null
>>> +++ b/hw/vfio/ccw.c
> [...]
> 
>>> +static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
>>> +{
>>> +    char *tmp, group_path[PATH_MAX];
>>> +    ssize_t len;
>>> +    int groupid;
>>> +
>>> +    tmp = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/%s/iommu_group",
>>> +                          cdev->hostid.cssid, cdev->hostid.ssid,
>>> +                          cdev->hostid.devid, cdev->mdevid);
>> May be worth replacing this static function by a common
>> vfio_get_device_group(VFIODevice *vbasedev, Error **errp) in common.c
>> that would be used by vfio/pci devices? It would use the sysfsdev
>> populated before.
> Are you propsing that we introduce a common interface for all of the
> devices which use the quite alike logic of populating the sysfsdev?
Yes that's what I meant.
> 
> I put this on my todo list, and prefer to defer it to a time after this
> set upstreamed.
OK no worries.
> 
>>> +    len = readlink(tmp, group_path, sizeof(group_path));
>>> +    g_free(tmp);
>>> +
>>> +    if (len <= 0 || len >= sizeof(group_path)) {
>>> +        error_setg(errp, "vfio: no iommu_group found");
>> may be good to align the error message with pci/platform. I noticed the
>> case where len==0 is handled as ENAMETOOLONG on pci/platform which looks
>> bad. Maybe this is why you changed it.
> I copy this from pci.c. :>
yep I know ;-)

Thanks

Eric
> 
> And I agree with you that, the error message is better to be aligned if
> it's possible to do that.
> 
>>> +        return NULL;
>>> +    }
>>> +
>>> +    group_path[len] = 0;
>>> +
>>> +    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>>> +        error_setg(errp, "vfio: failed to read %s", group_path);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return vfio_get_group(groupid, &address_space_memory, errp);
>>> +}
>>> +
>>> +static void vfio_ccw_put_group(VFIOGroup *group)
>> Is it really needed?
> Ok. Removed.
> 
>>> +{
>>> +    vfio_put_group(group);
>>> +}
>>> +
>>> +static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev;
>>> +    VFIOGroup *group;
>>> +    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
>>> +    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
>>> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>>> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>>> +
>>> +    /* Call the class init function for subchannel. */
>>> +    if (cdc->realize) {
>>> +        cdc->realize(cdev, vcdev->vdev.sysfsdev, errp);
>>> +        if (*errp) {
>> use local err?
> Ok.
> 
>>
>> Thanks
>>
>> Eric
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    group = vfio_ccw_get_group(cdev, errp);
>>> +    if (!group) {
>>> +        goto out_group_err;
>>> +    }
>>> +
>>> +    vcdev->vdev.ops = &vfio_ccw_ops;
>>> +    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
>>> +    vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>>> +                                       cdev->hostid.ssid, cdev->hostid.devid);
>>> +    QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>> +        if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
>>> +            error_setg(errp, "vfio: subchannel %s has already been attached",
>>> +                       vcdev->vdev.name);
>>> +            goto out_device_err;
>>> +        }
>>> +    }
>>> +
>>> +    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
>>> +        goto out_device_err;
>>> +    }
>>> +
>>> +    return;
>>> +
>>> +out_device_err:
>>> +    vfio_ccw_put_group(group);
>>> +out_group_err:
>>> +    if (cdc->unrealize) {
>>> +        cdc->unrealize(cdev, errp);
>>> +    }
>>> +}
>>> +
> [...]
> 
