From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH 2/2] vfio-ccw: support async command
 subregion
Date: Mon, 26 Nov 2018 19:01:55 +0100
Message-ID: <0a15ec08-5902-b6fa-f00d-883c0905c56b@linux.ibm.com>
References: <20181122165457.4517-1-cohuck@redhat.com>
	<20181122165457.4517-3-cohuck@redhat.com>
	<8fbbe0b6-6924-ad61-1d94-26517765f346@linux.ibm.com>
	<20181126105843.2efa2d06.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181126105843.2efa2d06.cohuck@redhat.com>
Content-Language: en-US
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On 26/11/2018 10:58, Cornelia Huck wrote:
> On Fri, 23 Nov 2018 15:13:12 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> On 22/11/2018 17:54, Cornelia Huck wrote:
>>> A vfio-ccw device may provide an async command subregion for
>>> issuing halt/clear subchannel requests. If it is present, use
>>> it for sending halt/clear request to the device; if not, fall
>>> back to emulation (as done today).
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    hw/s390x/css.c              |  27 +++++++--
>>>    hw/vfio/ccw.c               | 109 ++++++++++++++++++++++++++++++++=
+++-
>>>    include/hw/s390x/s390-ccw.h |   3 +
>>>    3 files changed, 133 insertions(+), 6 deletions(-)
>>>
>=20
>>> @@ -114,6 +120,87 @@ again:
>>>        }
>>>    }
>>>   =20
>>> +int vfio_ccw_handle_clear(SubchDev *sch)
>>> +{
>>> +    S390CCWDevice *cdev =3D sch->driver_data;
>>> +    VFIOCCWDevice *vcdev =3D DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>>> +    struct ccw_cmd_region *region =3D vcdev->async_cmd_region;
>>> +    int ret;
>>> +
>>> +    if (!vcdev->async_cmd_region) {
>>> +        /* Async command region not available, fall back to emulatio=
n */
>>> +        return -ENOSYS;
>>> +    }
>>> +
>>> +    memset(region, 0, sizeof(*region));
>>> +    region->command =3D VFIO_CCW_ASYNC_CMD_CSCH;
>>> +
>>> +again:
>>> +    ret =3D pwrite(vcdev->vdev.fd, region,
>>> +                 vcdev->async_cmd_region_size, vcdev->async_cmd_regi=
on_offset);
>>> +    if (ret !=3D vcdev->async_cmd_region_size) {
>>> +        if (errno =3D=3D EAGAIN) {
>>
>>
>> Where do the EAGAIN come from?
>=20
> It might be set by pwrite.

I saw that the man indicate this, and so we are legitimate to handle the=20
fail case, but I did not find EAGAIN in the path of the write for=20
accessing devices and I did not find it in the access to the CSS.

If we do not set it explicitly from the driver, the concern I have is:=20
isn't it dangerous to try again and shouldn't we better abort?


>=20
>>
>>
>>> +            goto again;
>>> +        }
>>> +        error_report("vfio-ccw: wirte I/O region failed with errno=3D=
%d", errno);
>=20
> I should also fix up this message here and for hsch as well :)
>=20
>>> +        ret =3D -errno;
>>> +    } else {
>>> +        ret =3D region->ret_code;
>>> +    }
>>> +    switch (ret) {
>>> +    case 0:
>>> +    case -ENODEV:
>>> +    case -EACCES:
>>
>> should never happen?
>=20
> It should not happen; but it can nevertheless be returned, so...

I understand: nothing to clear :)


>=20
>>
>>> +        return 0;
>>> +    case -EFAULT:
>>> +    default:
>>> +        sch_gen_unit_exception(sch);
>>> +        css_inject_io_interrupt(sch);
>>> +        return 0;
>>> +    }
>>> +}
>>> +
>>
>> otherwise LGTM
>=20
> Thanks!
>=20






--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
