Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C8BC7EE23
	for <linux-s390@archiver.kernel.org>; Tue, 23 May 2023 15:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjEWPvS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 May 2023 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjEWPvS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 May 2023 11:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D3121
        for <linux-s390@vger.kernel.org>; Tue, 23 May 2023 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684857030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wYFl8U0SDWnlIQQFAjgbnzByRprAY7BghMfujkqtBpA=;
        b=cMuWjnEcXhyevbHA1iv90pSRhUkmgMZ5utfWOj3EKGGFyWVodC49UnJxfBi/ssH6MCyaBa
        d4VuSbBK3GlOEhKrtSQTSMzsQzWHPOBpqnTONjVVVp9cTCrV33vIQ1CCDNBMsR+YjfKW18
        vgVRUc+JBtdY3507xbfUr6Vp7Neqc9o=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-NLGNrDZmMw2vg3WJQKUrew-1; Tue, 23 May 2023 11:50:29 -0400
X-MC-Unique: NLGNrDZmMw2vg3WJQKUrew-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-331139b46cfso6886785ab.1
        for <linux-s390@vger.kernel.org>; Tue, 23 May 2023 08:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684857028; x=1687449028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYFl8U0SDWnlIQQFAjgbnzByRprAY7BghMfujkqtBpA=;
        b=bC3jUAVEtJjyDTG0LfUdNGEmZ1RkQGCzxm3tJh7YLKXlDjkb+4PlhLh1Ifr/U1vY5y
         K53AI22cYli26xqsNLeYOwDrRJWMNa9Do7U6kKbm+hgIQH6XRuxyR5Ji9sAMWqE2QdOc
         ckPPHQLkZpz2YVNwb5MkySgHfctg7yF5K4GELy4h0y+nKoK+5TQsS9FC+76SS2e7Ah9p
         uc9aSNpaSZhFrIe5RwHTk5P4YgbJES1UKglLI0ipAsU4edS3CJUgAwPFcXnOBiWCETmm
         4ZSsOK6ZUpJJfeRPzaPFvbmSTVTr1MZeMsOLyPeAcBaHoUNduYJTAbvTRRwIF/sid7YI
         6mSQ==
X-Gm-Message-State: AC+VfDy6EqaLe7C6r0T185xW2dfNr0EViB/DLqai/Xx/CkGoFbNt0Um4
        e7u4O3MYv5wul5HfMPsy0osaaIc8Nrjqr5aYVzAm0lXRD7rfQ62yEGyy+2sUXDpmKy4OyxPQFG1
        1W64L/wAnLvnw2zIfTayJ8A==
X-Received: by 2002:a92:cc4e:0:b0:338:b887:b674 with SMTP id t14-20020a92cc4e000000b00338b887b674mr7921325ilq.2.1684857028276;
        Tue, 23 May 2023 08:50:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5L5cxZeYlEeuroxDhVXKppcAZQVL21daMeMkcovyH4v9JrjGeyYnpYWoYxJebm28zcXp2DNQ==
X-Received: by 2002:a92:cc4e:0:b0:338:b887:b674 with SMTP id t14-20020a92cc4e000000b00338b887b674mr7921317ilq.2.1684857027956;
        Tue, 23 May 2023 08:50:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y2-20020a056638228200b0040fa5258658sm2401119jas.77.2023.05.23.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:50:27 -0700 (PDT)
Date:   Tue, 23 May 2023 09:50:25 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "clegoate@redhat.com" <clegoate@redhat.com>
Subject: Re: [PATCH v11 20/23] vfio: Add VFIO_DEVICE_[AT|DE]TACH_IOMMUFD_PT
Message-ID: <20230523095025.1898297c.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529096D1BE1D337BA50884BC3409@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230513132827.39066-1-yi.l.liu@intel.com>
        <20230513132827.39066-21-yi.l.liu@intel.com>
        <20230522161534.32f3bf8e.alex.williamson@redhat.com>
        <DS0PR11MB7529096D1BE1D337BA50884BC3409@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 23 May 2023 01:20:17 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, May 23, 2023 6:16 AM
> >=20
> > On Sat, 13 May 2023 06:28:24 -0700
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >  =20
> > > This adds ioctl for userspace to attach device cdev fd to and detach
> > > from IOAS/hw_pagetable managed by iommufd.
> > >
> > >     VFIO_DEVICE_ATTACH_IOMMUFD_PT: attach vfio device to IOAS, hw_pag=
etable
> > > 				   managed by iommufd. Attach can be
> > > 				   undo by VFIO_DEVICE_DETACH_IOMMUFD_PT
> > > 				   or device fd close.
> > >     VFIO_DEVICE_DETACH_IOMMUFD_PT: detach vfio device from the curren=
t attached
> > > 				   IOAS or hw_pagetable managed by iommufd.
> > >
> > > Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> > > Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >  drivers/vfio/device_cdev.c | 66 ++++++++++++++++++++++++++++++++++++=
++
> > >  drivers/vfio/iommufd.c     | 18 +++++++++++
> > >  drivers/vfio/vfio.h        | 18 +++++++++++
> > >  drivers/vfio/vfio_main.c   |  8 +++++
> > >  include/uapi/linux/vfio.h  | 52 ++++++++++++++++++++++++++++++
> > >  5 files changed, 162 insertions(+)
> > >
> > > diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> > > index 291cc678a18b..3f14edb80a93 100644
> > > --- a/drivers/vfio/device_cdev.c
> > > +++ b/drivers/vfio/device_cdev.c
> > > @@ -174,6 +174,72 @@ long vfio_device_ioctl_bind_iommufd(struct vfio_=
device_file =20
> > *df, =20
> > >  	return ret;
> > >  }
> > >
> > > +int vfio_ioctl_device_attach(struct vfio_device_file *df,
> > > +			     struct vfio_device_attach_iommufd_pt __user *arg)
> > > +{
> > > +	struct vfio_device *device =3D df->device;
> > > +	struct vfio_device_attach_iommufd_pt attach;
> > > +	unsigned long minsz;
> > > +	int ret;
> > > +
> > > +	minsz =3D offsetofend(struct vfio_device_attach_iommufd_pt, pt_id);
> > > +
> > > +	if (copy_from_user(&attach, arg, minsz))
> > > +		return -EFAULT;
> > > +
> > > +	if (attach.argsz < minsz || attach.flags)
> > > +		return -EINVAL;
> > > +
> > > +	/* ATTACH only allowed for cdev fds */
> > > +	if (df->group)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&device->dev_set->lock);
> > > +	ret =3D vfio_iommufd_attach(device, &attach.pt_id);
> > > +	if (ret)
> > > +		goto out_unlock;
> > > +
> > > +	ret =3D copy_to_user(&arg->pt_id, &attach.pt_id,
> > > +			   sizeof(attach.pt_id)) ? -EFAULT : 0;
> > > +	if (ret)
> > > +		goto out_detach;
> > > +	mutex_unlock(&device->dev_set->lock);
> > > +
> > > +	return 0;
> > > +
> > > +out_detach:
> > > +	vfio_iommufd_detach(device);
> > > +out_unlock:
> > > +	mutex_unlock(&device->dev_set->lock);
> > > +	return ret;
> > > +}
> > > +
> > > +int vfio_ioctl_device_detach(struct vfio_device_file *df,
> > > +			     struct vfio_device_detach_iommufd_pt __user *arg)
> > > +{
> > > +	struct vfio_device *device =3D df->device;
> > > +	struct vfio_device_detach_iommufd_pt detach;
> > > +	unsigned long minsz;
> > > +
> > > +	minsz =3D offsetofend(struct vfio_device_detach_iommufd_pt, flags);
> > > +
> > > +	if (copy_from_user(&detach, arg, minsz))
> > > +		return -EFAULT;
> > > +
> > > +	if (detach.argsz < minsz || detach.flags)
> > > +		return -EINVAL;
> > > +
> > > +	/* DETACH only allowed for cdev fds */
> > > +	if (df->group)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&device->dev_set->lock);
> > > +	vfio_iommufd_detach(device);
> > > +	mutex_unlock(&device->dev_set->lock);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static char *vfio_device_devnode(const struct device *dev, umode_t *=
mode)
> > >  {
> > >  	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
> > > diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> > > index 83575b65ea01..799ea322a7d4 100644
> > > --- a/drivers/vfio/iommufd.c
> > > +++ b/drivers/vfio/iommufd.c
> > > @@ -112,6 +112,24 @@ void vfio_iommufd_unbind(struct vfio_device_file=
 *df)
> > >  		vdev->ops->unbind_iommufd(vdev);
> > >  }
> > >
> > > +int vfio_iommufd_attach(struct vfio_device *vdev, u32 *pt_id)
> > > +{
> > > +	lockdep_assert_held(&vdev->dev_set->lock);
> > > +
> > > +	if (vfio_device_is_noiommu(vdev))
> > > +		return 0; =20
> >=20
> > Isn't this an invalid operation for a noiommu cdev, ie. -EINVAL?  We
> > return success and copy back the provided pt_id, why would a user not
> > consider it a bug that they can't use whatever value was there with
> > iommufd? =20
>=20
> Yes, this is the question I asked in [1]. At that time, it appears to me
> that better to allow it [2]. Maybe it's more suitable to ask it here.

=46rom an API perspective it seems wrong.  We return success without
doing anything.  A user would be right to consider it a bug that the
attach operation works but there's not actually any association to the
IOAS.  Thanks,

Alex


> [1] https://lore.kernel.org/kvm/c203f11f-4d9f-cf43-03ab-e41a858bdd92@inte=
l.com/
> [2] https://lore.kernel.org/kvm/ZFFUyhqID+LtUB%2FD@nvidia.com/
>=20
> > > +
> > > +	return vdev->ops->attach_ioas(vdev, pt_id);
> > > +}
> > > +
> > > +void vfio_iommufd_detach(struct vfio_device *vdev)
> > > +{
> > > +	lockdep_assert_held(&vdev->dev_set->lock);
> > > +
> > > +	if (!vfio_device_is_noiommu(vdev))
> > > +		vdev->ops->detach_ioas(vdev);
> > > +}
> > > +
> > >  struct iommufd_ctx *vfio_iommufd_physical_ictx(struct vfio_device *v=
dev)
> > >  {
> > >  	if (vdev->iommufd_device)
> > > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > > index 8b359a7794be..50553f67600f 100644
> > > --- a/drivers/vfio/vfio.h
> > > +++ b/drivers/vfio/vfio.h
> > > @@ -241,6 +241,8 @@ int vfio_iommufd_bind(struct vfio_device_file *df=
);
> > >  void vfio_iommufd_unbind(struct vfio_device_file *df);
> > >  int vfio_iommufd_compat_attach_ioas(struct vfio_device *device,
> > >  				    struct iommufd_ctx *ictx);
> > > +int vfio_iommufd_attach(struct vfio_device *vdev, u32 *pt_id);
> > > +void vfio_iommufd_detach(struct vfio_device *vdev);
> > >  #else
> > >  static inline int
> > >  vfio_iommufd_compat_probe_noiommu(struct vfio_device *device,
> > > @@ -282,6 +284,10 @@ int vfio_device_fops_cdev_open(struct inode *ino=
de, struct =20
> > file *filep); =20
> > >  void vfio_device_cdev_close(struct vfio_device_file *df);
> > >  long vfio_device_ioctl_bind_iommufd(struct vfio_device_file *df,
> > >  				    struct vfio_device_bind_iommufd __user *arg);
> > > +int vfio_ioctl_device_attach(struct vfio_device_file *df,
> > > +			     struct vfio_device_attach_iommufd_pt __user *arg);
> > > +int vfio_ioctl_device_detach(struct vfio_device_file *df,
> > > +			     struct vfio_device_detach_iommufd_pt __user *arg);
> > >  int vfio_cdev_init(struct class *device_class);
> > >  void vfio_cdev_cleanup(void);
> > >  #else
> > > @@ -315,6 +321,18 @@ static inline long vfio_device_ioctl_bind_iommuf=
d(struct =20
> > vfio_device_file *df, =20
> > >  	return -EOPNOTSUPP;
> > >  }
> > >
> > > +static inline int vfio_ioctl_device_attach(struct vfio_device_file *=
df,
> > > +					   struct vfio_device_attach_iommufd_pt __user =20
> > *arg) =20
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static inline int vfio_ioctl_device_detach(struct vfio_device_file *=
df,
> > > +					   struct vfio_device_detach_iommufd_pt =20
> > __user *arg) =20
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > >  static inline int vfio_cdev_init(struct class *device_class)
> > >  {
> > >  	return 0;
> > > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > > index c9fa39ac4b02..8c3f26b4929b 100644
> > > --- a/drivers/vfio/vfio_main.c
> > > +++ b/drivers/vfio/vfio_main.c
> > > @@ -1165,6 +1165,14 @@ static long vfio_device_fops_unl_ioctl(struct =
file *filep,
> > >  		ret =3D vfio_ioctl_device_feature(device, (void __user *)arg);
> > >  		break;
> > >
> > > +	case VFIO_DEVICE_ATTACH_IOMMUFD_PT:
> > > +		ret =3D vfio_ioctl_device_attach(df, (void __user *)arg);
> > > +		break;
> > > +
> > > +	case VFIO_DEVICE_DETACH_IOMMUFD_PT:
> > > +		ret =3D vfio_ioctl_device_detach(df, (void __user *)arg);
> > > +		break;
> > > +
> > >  	default:
> > >  		if (unlikely(!device->ops->ioctl))
> > >  			ret =3D -EINVAL;
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 07c917de31e9..770f5f949929 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -222,6 +222,58 @@ struct vfio_device_bind_iommufd {
> > >
> > >  #define VFIO_DEVICE_BIND_IOMMUFD	_IO(VFIO_TYPE, VFIO_BASE + 19)
> > >
> > > +/*
> > > + * VFIO_DEVICE_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 20,
> > > + *					struct vfio_device_attach_iommufd_pt)
> > > + *
> > > + * Attach a vfio device to an iommufd address space specified by IOAS
> > > + * id or hw_pagetable (hwpt) id.
> > > + *
> > > + * Available only after a device has been bound to iommufd via
> > > + * VFIO_DEVICE_BIND_IOMMUFD
> > > + *
> > > + * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.
> > > + *
> > > + * @argsz:	User filled size of this data.
> > > + * @flags:	Must be 0.
> > > + * @pt_id:	Input the target id which can represent an ioas or a hwpt
> > > + *		allocated via iommufd subsystem.
> > > + *		Output the input ioas id or the attached hwpt id which could
> > > + *		be the specified hwpt itself or a hwpt automatically created
> > > + *		for the specified ioas by kernel during the attachment.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct vfio_device_attach_iommufd_pt {
> > > +	__u32	argsz;
> > > +	__u32	flags;
> > > +	__u32	pt_id;
> > > +};
> > > +
> > > +#define VFIO_DEVICE_ATTACH_IOMMUFD_PT		_IO(VFIO_TYPE, =20
> > VFIO_BASE + 20) =20
> > > +
> > > +/*
> > > + * VFIO_DEVICE_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 21,
> > > + *					struct vfio_device_detach_iommufd_pt)
> > > + *
> > > + * Detach a vfio device from the iommufd address space it has been
> > > + * attached to. After it, device should be in a blocking DMA state.
> > > + *
> > > + * Available only after a device has been bound to iommufd via
> > > + * VFIO_DEVICE_BIND_IOMMUFD. =20
> >=20
> > These "[a]vailable only after" comments are meaningless, if the user
> > has the file descriptor the ioctl is available.  We can say that ATTACH
> > should be used after BIND to associate the device with an address space
> > within the bound iommufd and DETACH removes that association, but the
> > user is welcome to call everything in the wrong order and we need to be
> > prepared for that anyway.  Thanks, =20
>=20
> Oh, yes. it's available as long as FD is got. But it is expected to fail =
if
> the order is not met. This should be what the comment really wants
> to deliver. Will have a look at other ioctls as well.
>=20
> Regards,
> Yi Liu
>=20
> >=20
> > Alex
> >  =20
> > > + *
> > > + * @argsz:	User filled size of this data.
> > > + * @flags:	Must be 0.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct vfio_device_detach_iommufd_pt {
> > > +	__u32	argsz;
> > > +	__u32	flags;
> > > +};
> > > +
> > > +#define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, =20
> > VFIO_BASE + 21) =20
> > > +
> > >  /**
> > >   * VFIO_DEVICE_GET_INFO - _IOR(VFIO_TYPE, VFIO_BASE + 7,
> > >   *						struct vfio_device_info) =20
>=20

