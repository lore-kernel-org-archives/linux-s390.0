From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Fri, 25 Jan 2019 14:09:18 +0100
Message-ID: <20190125140918.64686aaf@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 21:37:44 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> >> @@ -188,25 +192,30 @@ static ssize_t vfio_ccw_mdev_write(struct=20
> >> mdev_device *mdev,
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vfio_ccw_private *private;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region *region;
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*ppos + count > sizeof(*region))
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private =3D dev_get_drvdata(mdev_parent=
_dev(mdev));
> >> -=C2=A0=C2=A0=C2=A0 if (private->state !=3D VFIO_CCW_STATE_IDLE)
> >> +=C2=A0=C2=A0=C2=A0 if (private->state =3D=3D VFIO_CCW_STATE_NOT_OPER =
||
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private->state =3D=3D VFIO=
_CCW_STATE_STANDBY)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
> >> +=C2=A0=C2=A0=C2=A0 if (!mutex_trylock(&private->io_mutex))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGAIN; =20
> >=20
> > Ah, I see Halil's difficulty here.
> >=20
> > It is true there is a race condition today, and that this doesn't=20
> > address it.=C2=A0 That's fine, add it to the todo list.=C2=A0 But even =
with that,=20
> > I don't see what the mutex is enforcing?=C2=A0 Two simultaneous SSCHs w=
ill be=20
> > serialized (one will get kicked out with a failed trylock() call), whil=
e=20
> > still leaving the window open between cc=3D0 on the SSCH and the=20
> > subsequent interrupt.=C2=A0 In the latter case, a second SSCH will come=
=20
> > through here, do the copy_from_user below, and then jump to fsm_io_busy=
=20
> > to return EAGAIN.=C2=A0 Do we really want to stomp on io_region in that=
 case?=20
> >  =C2=A0Why can't we simply return EAGAIN if state=3D=3DBUSY? =20
>=20
> (Answering my own questions as I skim patch 5...)
>=20
> Because of course this series is for async handling, while I was looking=
=20
> specifically at the synchronous code that exists today.  I guess then my=
=20
> question just remains on how the mutex is adding protection in the sync=20
> case, because that's still not apparent to me.  (Perhaps I missed it in=20
> a reply to Halil; if so I apologize, there were a lot when I returned.)

Careful, at the end we have vfio_ccw_mdev_write_io_region() and the
write callback for the capchain regions. We could return EAGAIN if
state=3D=3DBUSY in the vfio_ccw_mdev_write_io_region() (but I would prefer a
different error code -- see my other response).

I answered your mutex question as well. Just a small addendum the mutex
is not only for the cases the userspace acts sane (but also when it acts
insane;).

Halil
