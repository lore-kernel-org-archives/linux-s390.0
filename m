Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727111AbgJGJtk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 05:49:40 -0400
Date: Wed, 7 Oct 2020 11:49:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 08/10] s390/dasd: Display FC Endpoint Security
 information via sysfs
Message-ID: <20201007114928.6a088a7d.cohuck@redhat.com>
In-Reply-To: <d88b8230-993e-d63d-394a-efcaf60f813d@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
        <20201002193940.24012-9-sth@linux.ibm.com>
        <20201006122632.098149ba.cohuck@redhat.com>
        <d88b8230-993e-d63d-394a-efcaf60f813d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Jan =?UTF-8?B?SMO2cHBuZXI=?= <hoeppner@linux.ibm.com>
Cc: Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 6 Oct 2020 18:57:46 +0200
Jan H=C3=B6ppner <hoeppner@linux.ibm.com> wrote:

> On 10/6/20 12:26 PM, Cornelia Huck wrote:
> > On Fri,  2 Oct 2020 21:39:38 +0200
> > Stefan Haberland <sth@linux.ibm.com> wrote:
> >  =20
> >> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> >>
> >> Add a new sysfs attribute (fc_security) per device and per operational
> >> channel path. The information of the current FC Endpoint Security state
> >> is received through the CIO layer.
> >>
> >> The state of the FC Endpoint Security can be either "Unsupported",
> >> "Authentication", or "Encryption".
> >>
> >> For example:
> >> $ cat /sys/bus/ccw/devices/0.0.c600/fc_security
> >> Encryption
> >>
> >> If any of the operational paths is in a state different from all
> >> others, the device sysfs attribute will display the additional state
> >> "Inconsistent".
> >>
> >> The sysfs attributes per paths are organised in a new directory called
> >> "paths_info" with subdirectories for each path.
> >>
> >> /sys/bus/ccw/devices/0.0.c600/paths_info/
> >> =E2=94=9C=E2=94=80=E2=94=80 0.38
> >> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> >> =E2=94=9C=E2=94=80=E2=94=80 0.39
> >> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> >> =E2=94=9C=E2=94=80=E2=94=80 0.3a
> >> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> >> =E2=94=94=E2=94=80=E2=94=80 0.3b
> >>     =E2=94=94=E2=94=80=E2=94=80 fc_security
> >>
> >> Reference-ID: IO1812
> >> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> >> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> >> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> >> ---
> >>  drivers/s390/block/dasd_devmap.c | 105 +++++++++++++++++++++++++++++++
> >>  drivers/s390/block/dasd_eckd.c   |  30 +++++++++
> >>  drivers/s390/block/dasd_int.h    |  68 ++++++++++++++++++++
> >>  3 files changed, 203 insertions(+)
> >> =20
> >=20
> > (...)
> >  =20
> >> +static struct kobj_type path_attr_type =3D {
> >> +	.release	=3D dasd_path_release, =20
> >=20
> > This function does nothing; I think there's something wrong with your
> > kobject handling? =20
>=20
> Explanation below.
>=20
> >  =20
> >> +	.default_attrs	=3D paths_info_attrs,
> >> +	.sysfs_ops	=3D &kobj_sysfs_ops,
> >> +};
> >> +
> >> +static void dasd_path_init_kobj(struct dasd_device *device, int chp)
> >> +{
> >> +	device->path[chp].kobj.kset =3D device->paths_info;
> >> +	kobject_init(&device->path[chp].kobj, &path_attr_type); =20
> >=20
> > This inits a static kobject; as you never free it, doesn't the code =20
>=20
> kobject_put() frees the kobject data.

Not quite; if the last ref is put, it invokes the provided ->release
callback and frees the allocated name. If the ->release callback does
not free the object embedding the kobject, only the name is freed
AFAICS.

>=20
> > moan about state_initialized if you try to do that a second time? =20
>=20
> No, because we check whether we have this kobject already present
> in sysfs before we try to initialize it (we have in_sysfs per path
> object for this).

I might be confused by the path revalidation logic; but don't you unset
in_sysfs when you remove the path object? What happens when you readd it?

>=20
> >  =20
> >> +}
> >> +
> >> +void dasd_path_create_kobj(struct dasd_device *device, int chp)
> >> +{
> >> +	int rc;
> >> +
> >> +	if (test_bit(DASD_FLAG_OFFLINE, &device->flags))
> >> +		return;
> >> +	if (!device->paths_info) {
> >> +		dev_warn(&device->cdev->dev, "Unable to create paths objects\n"); =
=20
> >=20
> > I guess this warns every time you come along here, is warning more than
> > once useful?
> >  =20
>=20
> paths_info is a kset created during the device initialization. Do you mea=
n,
> in case the kset creation fails, this check here should only warn once?
> I'm not sure about that, hm.

If the kset could not be set up during init, you'll hit this for every
path object you want to add afterwards -- one warning per device of
that should be enough, I guess :)

>=20
> >> +		return;
> >> +	}
> >> +	if (device->path[chp].in_sysfs)
> >> +		return;
> >> +	if (!device->path[chp].conf_data) =20
> >=20
> > Out of interest: Have you tried this with vfio-ccw under QEMU, where
> > some information is simply not available? =20
>=20
> I did not, sorry.
>=20
> >  =20
> >> +		return;
> >> +
> >> +	dasd_path_init_kobj(device, chp);
> >> +
> >> +	rc =3D kobject_add(&device->path[chp].kobj, NULL, "%x.%02x",
> >> +			 device->path[chp].cssid, device->path[chp].chpid);
> >> +	if (rc)
> >> +		kobject_put(&device->path[chp].kobj); =20
> >=20
> > This will eventually lead to the nop release function, which doesn't
> > unset state_initialized (see above) -- but OTOH, it shouldn't muck
> > around with kobject internals anyway. =20
>=20
> The release function is supposed to free memory of the structure where
> the kobject lies in (our release function is explained below).
> The rest is taking care of by the kobject library.

Yes, but the kobject code does not unset state_initialized.
>=20
> >=20
> > I think the kobjects really want to be dynamically allocated; instead
> > of going through a remove/add cycle, is there a way to make path
> > objects "invisible" instead? Or add an "available" attribute, and error
> > out reading any other attribute?

> > (...)
> >  =20
> >> +static inline void dasd_path_release(struct kobject *kobj)
> >> +{
> >> +/* Memory for the dasd_path kobject is freed when dasd_free_device() =
is called */
> >> +}
> >> + =20
> >=20
> > As already said, I don't think that's a correct way to implement this.
> >  =20
>=20
> As you correctly pointed out, our release function doesn't do anything.
> This is because our path data is a (static) part of our device.
> This data is critical to keep our devices operational.
> We can't simply rely on allocated memory if systems are under stress.=20

Yes, avoiding freeing and reallocating memory certainly makes sense.

>=20
> Having this data dynamically allocated involves a lot of rework of our
> path handling as well. There are a few things that are subject to improve=
ment
> and evaluating whether our dasd_path structures can be dynamic is one of
> these things. However, even then, the above concern persists and I
> highly doubt that dynamic dasd_paths objects are doable for us at this
> moment.
>=20
> I do understand the concerns, however, we release the memory for dasd_path
> structures eventually when dasd_free_device() is called. Until that point,
> the data has to be kept alive. The rest is taking care of by the kobject
> library.

Yes, there doesn't seem to be any memory leakage.

> In our path handling we also make sure that we can always verify/validate
> paths information even if a system is under high memory pressure. Another
> reason why it would contradictory for dasd_path objects to be dynamic.
>=20
> I hope this explains the reasoning behind the release function.

I understand where you're coming from.

However, "static" kobjects (in the sense of "we may re-register the
same kobject") are still problematic. Is there any way to simply
"disappear" path objects that are not valid at the moment, or mark them
as not valid?

Also, the simple act of registering/unregistering a kobject already
creates stress from its sysfs interactions... it seems you should try
to avoid that as well?
