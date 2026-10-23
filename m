Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778805;
	b=xutnWYRjPJWry9YpMS5Z9MgtKzrlJcr3Tv/bCmAfYJRU+FcxSQo8BYOCS308AZr3MH+o
	 WDsD9FNgyGv8SiMSpEjX040HO9FR/95Uwuum0ePcQmm/ATouJxf03hP3LUYdrvESeo7wq
	 WL9C4bdAhMnWJ96EAILomFxXHDUEyk9dSUh/4uqSnu87on7CSOKA6Au5QW3RkxaHfqcDk
	 vCxWg2WpVz8lvVEJKtbKVDgJpV3qeXQOq5jsDh91Y2C8TNmwkXuv82y97QvvcJlVjqLJu
	 SAHrjOvEEnkTExjQnefyHizDyzabVM5UJURbhHYpcpSFQ2WZAEx9QvZZE12NHne7ieg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Far/7Ekig79VrE3rpqYLjY776SSZgFdewWRT1MbjP+A=;
	b=HhNwii1LTHwaXAm66cau/9MyCSJOeQ7mThRiwTpYE0wfTtSzGtMECIHrv0PUJVXCQcYq
	 KPKxPo9FqWQb3US3JiAXGgTuUihtkEn/wmRUUEXuOoTZkl7HIc/+Z3rOUx3cIYuiLMEAD
	 V/BuhucPz+pT9WCI0WgIWiBQkGvHJC3C0VHYNcOpj/E/IeNMizHUDqCS6Mlq0W25hBIFT
	 DN9Nwdpv/T1tb7DjJCgnruHFCudbHanUdwNBphW3XyBPJdyVmzPonLt7NNJB7DzxltH/C
	 AGNkUvuZ5gdcyrsJzFUwCAn/Gk8kqpm7U9tyo208BLUV/SoqQqtNE/IcWfRQ2wX+1ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGJiLB+B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A2606A31A;
	Fri, 23 Oct 2026 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGJiLB+B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6357C1F01825;
	Fri, 23 Oct 2026 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778804;
	bh=Far/7Ekig79VrE3rpqYLjY776SSZgFdewWRT1MbjP+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RGJiLB+B1nlwB6ViVZSYWN3CpLNYUNFJl/OlWim1sJ4X0z2VcPoosf1th9iOhLxhC
	 +aJ/YOeC1SK9e+uLSwMA1KGiDX0r8S9X55ljxRCVBdSQhxSX4Qc92lgruSz8g2BQBx
	 zXTCn5/XyiqoZQAGsUfmLevYeL89jJtZNTXEODNlX0UCVNYZYnLdMNvT+G5Ho2TJGI
	 lTi13Ckxy49VU96sG2axp6oH8AKii5kAYu0M7CQYCUwTc5AdXUogTzWPmg3f47E2DZ
	 tZ9jminZHrgeK+KIoMO5IbKOeoatqra/3n7ax4vikFZlp25hbg2ejouo56gu0Iv7BY
	 RvaxqJIl0fHLg==
Message-ID: <sashiko-outbox-183040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/15] s390/vfio-ap: Add 'migration' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-15-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:06:43 +0000
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
- [Medium] s390/vfio-ap: features_show() uses guest-side ap_is_se_guest() o=
n KVM host
--

commit 43fb24f8f56fe7dba5cb74bbc8da847cfac6779e
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add 'migration' feature to sysfs 'features' attribute

This commit adds the migration feature string to the vfio_ap matrix sysfs
features attribute unless ap_is_se_guest() returns true.

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio=
_ap_drv.c
> index 8e69ed286bb9c..c63a050a23569 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -26,9 +26,21 @@ MODULE_LICENSE("GPL v2");
>  struct ap_matrix_dev *matrix_dev;
>  debug_info_t *vfio_ap_dbf_info;
> =20
> +#define VFIO_AP_BASE_FEATURES	"guest_matrix hotplug ap_config"
> +#define VFIO_AP_SE_EXCLUDED_FEATURES "migration"
> +
>  static ssize_t features_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
> +	/*
> +	 * SE guests do not support live guest migration; emit only the base
> +	 * feature set for them.
> +	 */
> +	if (ap_is_se_guest())
> +		return sysfs_emit(buf, "%s\n", VFIO_AP_BASE_FEATURES);
> +
> +	/* Non-SE: base features plus those not available on SE guests */
> +	return sysfs_emit(buf, "%s %s\n", VFIO_AP_BASE_FEATURES,
> +			  VFIO_AP_SE_EXCLUDED_FEATURES);

[Severity: Medium]
Can ap_is_se_guest() ever evaluate to true here on a KVM host?

Looking at drivers/s390/crypto/ap_bus.c:

bool ap_is_se_guest(void)
{
	return is_prot_virt_guest() && ap_sb_available();
}

and arch/s390/boot/uv.c:uv_query_info():

	if (test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)uvcb.inst=
_calls_list) &&
	    test_bit_inv(BIT_UVC_CMD_REMOVE_SHARED_ACCESS, (unsigned long *)uvcb.i=
nst_calls_list))
		prot_virt_guest =3D 1;

is_prot_virt_guest() checks whether the currently running kernel is itself a
protected virtualization guest, which is mutually exclusive with running as=
 a
KVM host in is_prot_virt_host_capable().

Because vfio_ap runs on the KVM host, ap_is_se_guest() will always return
false in features_show(), as well as in the earlier patches in this series =
in
drivers/s390/crypto/vfio_ap_migration.c:

vfio_ap_mdev_probe() -> vfio_ap_setup_vfio_device_migration():
	if (ap_is_se_guest())
		return;

	matrix_mdev->vdev.migration_flags =3D VFIO_MIGRATION_STOP_COPY;
	matrix_mdev->vdev.mig_ops =3D &vfio_ap_migration_ops;

and vfio_ap_mdev_open_device() -> vfio_ap_init_migration_data():
	if (ap_is_se_guest())
		return 0;

Additionally, /sys/devices/vfio_ap/matrix/features is a host-wide attribute=
 on
matrix_dev, whereas whether a KVM guest uses Secure Execution is a per-VM
runtime property (such as kvm_s390_pv_is_protected(matrix_mdev->kvm) after =
the
guest transitions into protected mode via KVM_PV_ENABLE), and a single host
can run both SE and non-SE guests simultaneously.

Should the SE guest migration restriction be enforced per guest or mdev usi=
ng
host-side KVM protected virtualization state rather than ap_is_se_guest()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D14
