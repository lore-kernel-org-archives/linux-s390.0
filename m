Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 31 Jan 2019 10:27:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio: hint if callbacks surprisingly might sleep
Message-ID: <20190131102713-mutt-send-email-mst@kernel.org>
References: <20190131125314.29647-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131125314.29647-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 31, 2019 at 01:53:14PM +0100, Cornelia Huck wrote:
> A virtio transport is free to implement some of the callbacks in
> virtio_config_ops in a matter that they cannot be called from
> atomic context (e.g. virtio-ccw, which maps a lot of the callbacks
> to channel I/O, which is an inherently asynchronous mechanism).
> This can be very surprising for developers using the much more
> common virtio-pci transport, just to find out that things break
> when used on s390.
> 
> The documentation for virtio_config_ops now contains a comment
> explaining this, but it makes sense to add a might_sleep() annotation
> to various wrapper functions in the virtio core to avoid surprises
> later.
> 
> Note that annotations are NOT added to two classes of calls:
> - direct calls from device drivers (all current callers should be
>   fine, however)
> - calls which clearly won't be made from atomic context (such as
>   those ultimately coming in via the driver core)
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>


Makes sense to me. I don't think we should push our luck in
this release though, better defer until the merge window.

> ---
> 
> I think it is safe to add this now that the issues with the balloon
> have been fixed.
> 
> Note that this is not bulletproof (nor is it inteded to be). The
> intention is to make it easier for people to catch problems earlier.
> 
> ---
>  drivers/virtio/virtio.c       |  2 ++
>  include/linux/virtio_config.h | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 59e36ef4920f..98b30f54342c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -161,6 +161,7 @@ EXPORT_SYMBOL_GPL(virtio_config_enable);
>  
>  void virtio_add_status(struct virtio_device *dev, unsigned int status)
>  {
> +	might_sleep();
>  	dev->config->set_status(dev, dev->config->get_status(dev) | status);
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
> @@ -170,6 +171,7 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	int ret = dev->config->finalize_features(dev);
>  	unsigned status;
>  
> +	might_sleep();
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 987b6491b946..bb4cc4910750 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -290,6 +290,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
>  /* Config space accessors. */
>  #define virtio_cread(vdev, structname, member, ptr)			\
>  	do {								\
> +		might_sleep();						\
>  		/* Must match the member's type, and be integer */	\
>  		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
>  			(*ptr) = 1;					\
> @@ -319,6 +320,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
>  /* Config space accessors. */
>  #define virtio_cwrite(vdev, structname, member, ptr)			\
>  	do {								\
> +		might_sleep();						\
>  		/* Must match the member's type, and be integer */	\
>  		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
>  			BUG_ON((*ptr) == 1);				\
> @@ -358,6 +360,7 @@ static inline void __virtio_cread_many(struct virtio_device *vdev,
>  		vdev->config->generation(vdev) : 0;
>  	int i;
>  
> +	might_sleep();
>  	do {
>  		old = gen;
>  
> @@ -380,6 +383,8 @@ static inline void virtio_cread_bytes(struct virtio_device *vdev,
>  static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
>  {
>  	u8 ret;
> +
> +	might_sleep();
>  	vdev->config->get(vdev, offset, &ret, sizeof(ret));
>  	return ret;
>  }
> @@ -387,6 +392,7 @@ static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
>  static inline void virtio_cwrite8(struct virtio_device *vdev,
>  				  unsigned int offset, u8 val)
>  {
> +	might_sleep();
>  	vdev->config->set(vdev, offset, &val, sizeof(val));
>  }
>  
> @@ -394,6 +400,8 @@ static inline u16 virtio_cread16(struct virtio_device *vdev,
>  				 unsigned int offset)
>  {
>  	u16 ret;
> +
> +	might_sleep();
>  	vdev->config->get(vdev, offset, &ret, sizeof(ret));
>  	return virtio16_to_cpu(vdev, (__force __virtio16)ret);
>  }
> @@ -401,6 +409,7 @@ static inline u16 virtio_cread16(struct virtio_device *vdev,
>  static inline void virtio_cwrite16(struct virtio_device *vdev,
>  				   unsigned int offset, u16 val)
>  {
> +	might_sleep();
>  	val = (__force u16)cpu_to_virtio16(vdev, val);
>  	vdev->config->set(vdev, offset, &val, sizeof(val));
>  }
> @@ -409,6 +418,8 @@ static inline u32 virtio_cread32(struct virtio_device *vdev,
>  				 unsigned int offset)
>  {
>  	u32 ret;
> +
> +	might_sleep();
>  	vdev->config->get(vdev, offset, &ret, sizeof(ret));
>  	return virtio32_to_cpu(vdev, (__force __virtio32)ret);
>  }
> @@ -416,6 +427,7 @@ static inline u32 virtio_cread32(struct virtio_device *vdev,
>  static inline void virtio_cwrite32(struct virtio_device *vdev,
>  				   unsigned int offset, u32 val)
>  {
> +	might_sleep();
>  	val = (__force u32)cpu_to_virtio32(vdev, val);
>  	vdev->config->set(vdev, offset, &val, sizeof(val));
>  }
> @@ -431,6 +443,7 @@ static inline u64 virtio_cread64(struct virtio_device *vdev,
>  static inline void virtio_cwrite64(struct virtio_device *vdev,
>  				   unsigned int offset, u64 val)
>  {
> +	might_sleep();
>  	val = (__force u64)cpu_to_virtio64(vdev, val);
>  	vdev->config->set(vdev, offset, &val, sizeof(val));
>  }
> -- 
> 2.17.2
