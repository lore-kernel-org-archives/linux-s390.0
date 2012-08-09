From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/4] s390/kvm: Handle hosts not supporting
	s390-virtio.
Date: Fri, 10 Aug 2012 01:09:15 +0200
Message-ID: <1DF99033-5FD5-40ED-9221-61E7EA5A9219@suse.de>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1344351168-2568-2-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 07.08.2012, at 16:52, Cornelia Huck wrote:

> Running under a kvm host does not necessarily imply the presence of
> a page mapped above the main memory with the virtio information;
> however, the code includes a hard coded access to that page.
>=20
> Instead, check for the presence of the page and exit gracefully
> before we hit an addressing exception if it does not exist.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> drivers/s390/kvm/kvm_virtio.c | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/s390/kvm/kvm_virtio.c =
b/drivers/s390/kvm/kvm_virtio.c
> index 47cccd5..408447c 100644
> --- a/drivers/s390/kvm/kvm_virtio.c
> +++ b/drivers/s390/kvm/kvm_virtio.c
> @@ -418,6 +418,21 @@ static void kvm_extint_handler(struct ext_code =
ext_code,
> 	}
> }
>=20
> +static int __init test_devices_support(void)

Today we know what this function does, but the next person running into =
it has no clue. Maybe add a nice description here that you're trying to =
access memory above ram? (is this even what you're doing here? my s390 =
asm is slightly rusty) :)

Alex

> +{
> +	int ccode =3D -EIO;
> +
> +	asm volatile(
> +		"0:	cli	0(%1),0\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28\n"
> +		"1:\n"
> +		EX_TABLE(0b,1b)
> +		: "+d" (ccode)
> +		: "a" (kvm_devices)
> +		: "cc");
> +	return ccode;
> +}
> /*
>  * Init function for virtio
>  * devices are in a single page above top of "normal" mem
> @@ -443,6 +458,12 @@ static int __init kvm_devices_init(void)
> 	}
>=20
> 	kvm_devices =3D (void *) real_memory_size;
> +	if (test_devices_support() < 0) {
> +		vmem_remove_mapping(real_memory_size, PAGE_SIZE);
> +		root_device_unregister(kvm_root);
> +		/* No error. */
> +		return 0;
> +	}
>=20
> 	INIT_WORK(&hotplug_work, hotplug_devices);
>=20
> --=20
> 1.7.11.4
>=20
