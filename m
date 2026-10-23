Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779000;
	b=0xUJL4EFoDHz+s7Z3aKWhFP4q51uiywdQnzPboQ8VddyrvlXpcn6jsivm1Q0k9BeeOlj
	 l3P+Px/x9sAVXYldsmGidggCqDXoYGPLFEoQtpvnhGiYBD69FSUSDwAoXqarkNJ7kobPj
	 VmXDJOXG/RoHdFS3OaWYrOizqwTw1s8fSlURaxxbaAGdhn89ZOBAgTb0KKywV23JMVQw4
	 DBy7yPahDDc6sfL0BpcXoywFgAFnj53wHJ+DogV6nAvWIYJ5lrNJW/u/T3lzcynSgZdx/
	 I9lgouiZaDQVo+g3RH91JMiktlXkPb3hadnG0+L1g+kJWje1OSXFU7s2XFqqCyFVBDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mbt4z8JugrzFnXQRzrFCFpRa6xUeGJM5dRh3kkeIz5E=;
	b=0i+z2dC/oFnNULrAYcGTbHiZLLy01mI0VFq1NzGd9hzWvRjPlNcuYpVWzN9lzgzuuwB4
	 PZjRGwfr5oJbgHUz/2TVKz8b0ebFPAfjVcPwGGQMq8uTUff2wog5NYgKFPtjFyfrJdrOu
	 U1IuO9riGDj9Y6kOltSqWf6IXw3+a3i9fJkI/wgadxxDbkLLBUR4aGuytx4MKgafRu7ty
	 h0KbjIEnEvFWw66lWCGWTDrc0btGQqsamM6hUnopKpqaB/6LfoiLsqMSWN3gFDUGSzTeV
	 rdW3Z9KKs6zoFytxz7PjsoY5d2inOc4p2WS3uedbxArACTA7m4gVcPg5dgOMzbXAw9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifxI9NXT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B345606A320;
	Fri, 23 Oct 2026 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifxI9NXT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862AB1F01825;
	Fri, 23 Oct 2026 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778999;
	bh=Mbt4z8JugrzFnXQRzrFCFpRa6xUeGJM5dRh3kkeIz5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ifxI9NXTrmu1l+giNduGB6BHE3sLofWwpRYptv1eCkBb18TD/1qgG1caVMwGY0N0C
	 J8naBx1MW5lBTl2gIAtDM5vVSdfBShqF4/VoOSrx1COcetuC5FJmbnSkXwJg5sUox4
	 /3Q7I2fHjVju/TXju6xflshR6nrmnT6VdsK0zFoWiglL3JoTdHm67XAx/kBigv4IMd
	 suuUBqqDF5SYBMW8go43TJbFZeaGpdPw7syeuunXz1ytjDz0xZMbtbhK91gWL72XWl
	 jR1xz9XFEDXhw910kDoVG3ybKNjsQUbWbe6NJVKfd+U19O7I9xVGZJ1v5XSQH0CLRu
	 YlqMGPyxbYHQQ==
Message-ID: <sashiko-outbox-183047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/15] s390/vfio-ap: Add live guest migration
 chapter to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-16-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-16-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:09:59 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] s390/vfio-ap: outdated migration error logs and return codes in vfi=
o-ap.rst
--

commit fc329ac666c2f8054a2481eb51b1b63f8f3ee4bd
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

This commit adds a Live Guest Migration chapter to
Documentation/arch/s390/vfio-ap.rst describing how to configure and
troubleshoot live guest migration for KVM guests with passed-through AP
devices, along with minor comment updates in the vfio_ap driver.

> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s39=
0/vfio-ap.rst
> index ac0c07f76ddd7..f5d9e32875035 100644
> --- a/Documentation/arch/s390/vfio-ap.rst
> +++ b/Documentation/arch/s390/vfio-ap.rst

[ ... ]

> +3. Assign adapters, domains and control domains to the destination media=
ted device
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> +Assign the same adapters, domains and control domains to the destination
> +mediated device as are assigned to the source guest's mediated device. F=
or
> +example, using the same adapters, domains and control domains from the
> +previous step:
> +
> +.. code-block:: bash
> +
> +   echo 0x0 > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e=
3a8804/assign_adapter
> +   echo 0x14 > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22=
e3a8804/assign_adapter
> +   echo 0x16 > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22=
e3a8804/assign_adapter
> +   echo 0x33 > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22=
e3a8804/assign_domain
> +   echo 0x3a > /sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22=
e3a8804/assign_domain

[Severity: Low]
This isn't a bug, but since this example states that it assigns the adapter=
s,
domains, and control domains from the previous steps, should it also include
the assign_control_domain commands for 0x33 and 0x3a?

[ ... ]

> +One or more queues are not bound to the vfio_ap driver on the destinatio=
n host
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
> +The queue devices passed through to the source guest are not installed i=
n the
> +destination host or are not bound to its vfio_ap device driver.
> +
> +**Source host**
> +
> ++--------------+--------------------------------------------------------=
--------+
> +| Log          | Message                                                =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| Console log: | error: operation failed: migration failed. Message from=
 the    |
> +|              | source host: operation failed: job 'migration out' fail=
ed:     |
> +|              | Sibling indicated error 1. Message from the destination=
 host:  |
> +|              | operation failed: job 'migration in' failed: load of mi=
gration |
> +|              | failed: No such device: Failed to load vmstate version_=
id: 1,  |
> +|              | ret: -19                                               =
        |
> ++--------------+--------------------------------------------------------=
--------+
> +
> +**Destination host**
> +
> ++--------------+--------------------------------------------------------=
--------+
> +| Kernel log:  | vfio_ap_mdev $UUID: Queue $APID.$APQI not available to =
        |
> +|              | vfio_ap driver on target host                          =
        |
> ++--------------+--------------------------------------------------------=
--------+
> +| QEMU log:    | shutting down, reason=3Dfailed                         =
          |
> +|              | qemu-system-s390x: terminating on signal $SIGNAL_NUM fr=
om      |
> +|              | pid $PID $DAEMON                                       =
        |
> ++--------------+--------------------------------------------------------=
--------+
> +
> +
> +One or more control domains are not available on the destination host
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The control domains passed through to the source guest are not installed=
 on the
> +destination host.
> +
> +**Source host**
> +
> ++--------------+--------------------------------------------------------=
--------+
> +| Log          | Message                                                =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| Console log: | error: operation failed: migration failed. Message from=
 the    |
> +|              | source host: operation failed: job 'migration out' fail=
ed:     |
> +|              | Sibling indicated error 1. Message from the destination=
 host:  |
> +|              | operation failed: job 'migration in' failed: load of mi=
gration |
> +|              | failed: No such device: Failed to load vmstate version_=
id: 1,  |
> +|              | ret: -19                                               =
        |
> ++--------------+--------------------------------------------------------=
--------+
> +
> +**Destination host**
> +
> ++--------------+--------------------------------------------------------=
--------+
> +| Kernel log:  | vfio_ap_mdev $UUID: Control domain $DOMAIN_NUM not avai=
lable   |
> +|              | on the destination host                                =
        |
> ++--------------+--------------------------------------------------------=
--------+

[Severity: Low]
Are the documented kernel log messages and return codes in these two sectio=
ns
out of sync with the current implementation in
drivers/s390/crypto/vfio_ap_migration.c?

When a queue or control domain from the source guest is missing on the
destination host, do_post_copy_validation() calls
ap_config_is_subset_of_shadow_apcb():

drivers/s390/crypto/vfio_ap_migration.c:ap_config_is_subset_of_shadow_apcb(=
) {
	for (int i =3D 0; i < source_config->num_queues; i++) {
		...
		if (!test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) ||
		    !test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
			pr_err_ratelimited("vfio_ap_mdev %s: Queue %02lx.%04lx not in destinatio=
n mdev's AP configuration\n",
					   mdev_name, apid, apqi);
			ret =3D false;
		}
	}

	for_each_set_bit_inv(domain_num, (unsigned long *)source_config->adm,
			     AP_DOMAINS) {
		if (!test_bit_inv(domain_num, matrix_mdev->shadow_apcb.adm)) {
			pr_err_ratelimited("vfio_ap_mdev %s: Control domain %04lx not in destina=
tion mdev's AP configuration\n",
					   mdev_name, domain_num);
			ret =3D false;
		}
	}
}

And do_post_copy_validation() then returns -EINVAL (-22, Invalid argument)
rather than -ENODEV (-19, No such device):

	if (!ap_config_is_subset_of_shadow_apcb(mdev_name, matrix_mdev,
						source_config))
		return -EINVAL;

Should the documentation be updated to reflect the "not in destination mdev=
's
AP configuration" messages and -EINVAL (-22) return code?

[ ... ]

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 660b5a21fe9e8..ac135872da2fa 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -217,8 +217,9 @@ static const struct vfio_migration_ops vfio_ap_migrat=
ion_ops;
>  /**
>   * vfio_ap_setup_vfio_device_migration:
>   *
> + * Enable
>   * Plug the object containing the function pointers to the migration cal=
lbacks
> - * required to facilitate VFIO AP migration into the mdev
> + * used to facilitate migration of a vfio-ap device.

[Severity: Low]
This isn't a bug, but was the stray "Enable" line in the comment above
vfio_ap_setup_vfio_device_migration() left in by mistake?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D15
