From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH 1/3] vfio-ccw: add capabilities chain
Date: Fri, 23 Nov 2018 14:26:50 +0100
Message-ID: <dcf76e4e-95f3-e09d-7110-e66212b393c2@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
	<853a8421-af17-5130-51b7-3242cc10b989@linux.ibm.com>
	<20181123134517.0b21c263.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181123134517.0b21c263.cohuck@redhat.com>
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

On 23/11/2018 13:45, Cornelia Huck wrote:
> On Fri, 23 Nov 2018 13:28:25 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> On 22/11/2018 17:54, Cornelia Huck wrote:
>>> Allow to extend the regions used by vfio-ccw. The first user will be
>>> handling of halt and clear subchannel.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    drivers/s390/cio/vfio_ccw_ops.c     | 182 ++++++++++++++++++++++++=
----
>>>    drivers/s390/cio/vfio_ccw_private.h |  38 ++++++
>>>    include/uapi/linux/vfio.h           |   1 +
>>>    3 files changed, 195 insertions(+), 26 deletions(-)
>>>   =20
>>
>> Halt and clear have no parameters (the sub-channel ID is obviously the
>> one of the mediated device).
>>
>> Isn't adding a new sub-region for the purpose of handling halt and cle=
ar
>> superfluous?
>>
>> What is the reason not to use simple ioctls ?
>=20
> Should it turn out that we missed something and need an enhanced
> interface, we can simply stop providing this subregion and add a new
> subregion, without breaking existing userspace. We can't do that with
> ioctls.

OK, it is a good reason, took me a while but I get the interest of=20
capabilities for regions too.

>=20
> And moreover, this is only the first user of this infrastructure.
> There's also that path handling series that Dong Jia had posted early
> this year -- that would be an obvious user as well.
>=20

right.

Thanks.

Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
