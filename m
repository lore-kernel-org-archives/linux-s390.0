Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F63F167C;
	Wed, 29 Apr 2026 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462945; cv=none; b=GLAHTW//KnfOzb5szXHsRDDLuI9R8HPJ8ewHtd3QpbReiLwGDaUSBAThzO8zTAIaOKtezgaTP/XZq0l/WgTqdkNPnqviUDQIZDm+bLhvLrWgiMsU/zeIlYPCoqf1kHml6VbABYo4jIezyxdYv/Ud38N64xvCjDQZb98U1Of1v3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462945; c=relaxed/simple;
	bh=A9hmS+HXLf1KKOT/EJ3h1D9t69QIcAafyLjCeCLh+/s=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=eQaTzf6Y3Cy2FjxFiwUkpToAuwD99XU5qcxV61JTEsKUCA2NL8Mg0NYeaLhJGBtB2WA8iUCI7zeTeqQ1rm1qFDQl9QEL3f2oSrart9Ui7oFKweKmOA3PO/+aYkw0ji4CJaaQPASL3x18KqNDwzuZGJq1uOW33nyiV2doxXedc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TRTarlRm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TRTarlRm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SMtwf0584793;
	Wed, 29 Apr 2026 11:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gvLBB7
	d6n+XOR0meNtmM2rjr6HLxoUwMo9ez3k5k73E=; b=TRTarlRmo3+TxGhYq6njjV
	q6rAQUw1HaDBOl9LqTLaB7+LFYymfefwqWKbhpbaq7h5nT7fhhmDl5FmuMRv2Sag
	L9bOcmu8pGZ+vcU2D12eqVFkdLY1Nxe7TE5PmLZoCYQxGqcEuBvUwNzLf6Eu09gx
	3ke4MIniI+BQfdtUrm5rYDmr0jhRwPGZwoAfZ/v8Ov3roWWN1JLsFgx3gfYckb9w
	x9PAuxNz/qOUs28Iga7vxFeWBmEiW56MRvIHHqgtzNeaK2i2S1BOKjsU4TvQRcR6
	vEk3IBo9FMTO5KInIlUOKD0Wmzhiv3uixBcrYNiC6mx6Ar4haGq3uAv6HjHc7nBA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9ra7ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 11:42:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TBdD6A001933;
	Wed, 29 Apr 2026 11:42:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqe7eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 11:42:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TBgEYc38928642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 11:42:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E61EE58056;
	Wed, 29 Apr 2026 11:42:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 339CB5803F;
	Wed, 29 Apr 2026 11:42:13 +0000 (GMT)
Received: from [9.52.215.169] (unknown [9.52.215.169])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 11:42:13 +0000 (GMT)
Message-ID: <08008a2a61556482c71f7f0ed65106e32e77f418.camel@linux.ibm.com>
Subject: Re: [PATCH v14 4/7] s390/pci: Store PCI error information for
 passthrough devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        mjrosato@linux.ibm.com
In-Reply-To: <20260421163031.704-5-alifm@linux.ibm.com>
References: <20260421163031.704-1-alifm@linux.ibm.com>
	 <20260421163031.704-5-alifm@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 13:41:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zwVGk1Gb5KTZph3E3N3L0PlWdFXqkO81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDExNCBTYWx0ZWRfX5dFb6SFwXzrA
 rTSzcDgzRlUj/E1EeLw2blgsh2aDQRHWercq58kKKA7a6hfjisbJjbFWNybnVY61ZsNtlcf0axm
 Dq536uo0MO4eKl93gXqfdjG6vpkcUF2Jmy9K3MZSjWRz8xwOq3x98S1BsL4bIhLWCiR9NA0GyHH
 7p6PNmQP8HrxzY35H9Y/re4Iaua4iaLyArQwmS55bTmQc7742obqMIEdt7PVBtmd8MIew1IAQZ4
 ttAYCja4fa+BEpqMEF2X9UmD+2INYtqXX372JFSI6X1jLfBdiIE9B5ohvUSUO1HbDW2KhtGbToB
 gNHT2jp0wC/etKyueecXjt6Yws7t6FhLvDdQKaY58Ka3TfAex3Tv+tbAvT2wC2bsWaxtnIpR9Ws
 /eHe20ScskcqUeXT+9COhxSpb5iD8fsCTxmaDHjKEuxsIu+KthQcQnZtgyx5uTCIyD62Na2qgh0
 5xlZEC5jdOZx1QZ2iOw==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f1ee98 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=AsIre8QKLd4WNURQQ-AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zwVGk1Gb5KTZph3E3N3L0PlWdFXqkO81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290114

On Tue, 2026-04-21 at 09:30 -0700, Farhan Ali wrote:
> For a passthrough device we need co-operation from user space to recover
> the device. This would require to bubble up any error information to user
> space.  Let's store this error information for passthrough devices, so it
> can be retrieved later.
>=20
> We can now have userspace drivers (vfio-pci based) on s390x. The userspac=
e
> drivers will not have any KVM fd and so no kzdev associated with them. So
> we need to update the logic for detecting passthrough devices to not depe=
nd
> on struct kvm_zdev.
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h      |  30 ++++++++
>  arch/s390/pci/pci.c              |   1 +
>  arch/s390/pci/pci_event.c        | 117 +++++++++++++++++--------------
>  drivers/vfio/pci/vfio_pci_zdev.c |   9 ++-
>  4 files changed, 105 insertions(+), 52 deletions(-)
>=20
--- snip ---
> +
> +void zpci_start_mediated_recovery(struct zpci_dev *zdev)
> +{
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	zdev->pending_errs.mediated_recovery =3D true;
> +}
> +EXPORT_SYMBOL_GPL(zpci_start_mediated_recovery);
> +
> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
> +{
> +	struct pci_dev *pdev =3D NULL;
> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	zdev->pending_errs.mediated_recovery =3D false;
> +	pdev =3D pci_get_slot(zdev->zbus->bus, zdev->devfn);
> +	if (zdev->pending_errs.count)
> +		pr_info("%s: Unhandled PCI error events count=3D%d",
> +			pci_name(pdev), zdev->pending_errs.count);

Sashiko notes a possible ABBA locking issue here between
pending_errs_lock and the pci_bus_sem inside pci_get_slot(). I wonder
if that would also be visible with lockdep? Also Sashiko notes that
zdev->zbus->bus could be NULL I don't think this is possible at the
current callsites via vfio-pci though. Similarly I don't think
pci_get_slot() can really be NULL at the current call sites. This makes
me wonder however, would it maybe be cleaner to pass a struct pci_dev
here so you don't need the pci_get_slot() at all? Both
vfio_pci_zdev_open_device() and vfio_pci_zdev_close_device() have that
readily available via vdev->pdev.


> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
> +	pci_dev_put(pdev);
> +}
> +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
> +
>  static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev =
*pdev,
>  							 struct pci_driver *driver)
>  {
> @@ -175,7 +190,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pc=
i_dev *pdev,
>   * and the platform determines which functions are affected for
>   * multi-function devices.
>   */
> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev=
 *pdev)
> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev=
 *pdev,
> +							  struct zpci_ccdf_err *ccdf)
>  {
>  	pci_ers_result_t ers_res =3D PCI_ERS_RESULT_DISCONNECT;
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> @@ -194,13 +210,6 @@ static pci_ers_result_t zpci_event_attempt_error_rec=
overy(struct pci_dev *pdev)
>  	}
>  	pdev->error_state =3D pci_channel_io_frozen;
> =20
> -	if (is_passed_through(pdev)) {
> -		pr_info("%s: Cannot be recovered in the host because it is a pass-thro=
ugh device\n",
> -			pci_name(pdev));
> -		status_str =3D "failed (pass-through)";
> -		goto out_unlock;
> -	}
> -
>  	driver =3D to_pci_driver(pdev->dev.driver);
>  	if (!is_driver_supported(driver)) {
>  		if (!driver) {
> @@ -216,12 +225,24 @@ static pci_ers_result_t zpci_event_attempt_error_re=
covery(struct pci_dev *pdev)
>  		goto out_unlock;
>  	}
> =20
> +	zpci_store_pci_error(pdev, ccdf);
> +
>  	ers_res =3D zpci_event_notify_error_detected(pdev, driver);
>  	if (ers_result_indicates_abort(ers_res)) {
>  		status_str =3D "failed (abort on detection)";
>  		goto out_unlock;
>  	}
> =20
> +	scoped_guard(mutex, &zdev->pending_errs_lock) {
> +		if (zdev->pending_errs.mediated_recovery) {
> +			pr_info("%s: Leaving recovery of pass-through device to user-space\n"=
,
> +				pci_name(pdev));
> +			ers_res =3D PCI_ERS_RESULT_RECOVERED;
> +			status_str =3D "in progress";
> +			goto out_unlock;
> +		}
> +	}
> +

Sashiko notes that mixing goto unlock and lock guards within one
function is discouraged. Here it's not that hard to read since it is
just a scoped guard but I think we should still not mix it.

However if we also convert the device_lock() to a guard lock here the
goto would still make sense to go to the zpci_report_status() and that
is still a bit odd with guarded locks. So I think an alternative simple
fix, that makes this overall cleaner too, is to put the whole
scoped_guard() block above into a helper function then you can do the
goto out_unlock on that helper returning PCI_ERS_RESULT_RECVOERED in
line with e.g. zpci_event_notify_error_detected(). That way you don't
need to touch existing locks and you get to keep the guard locking.

>  	if (ers_res !=3D PCI_ERS_RESULT_NEED_RESET) {
>  		ers_res =3D zpci_event_do_error_state_clear(pdev, driver);
>  		if (ers_result_indicates_abort(ers_res)) {
> @@ -266,25 +287,19 @@ static pci_ers_result_t zpci_event_attempt_error_re=
covery(struct pci_dev *pdev)
>   * @pdev: PCI function for which to report
>   * @es: PCI channel failure state to report
>   */
> -static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_stat=
e_t es)
> +static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_stat=
e_t es,
> +				  struct zpci_ccdf_err *ccdf)
>  {
>  	struct pci_driver *driver;
> =20
>  	pci_dev_lock(pdev);
>  	pdev->error_state =3D es;
> -	/**
> -	 * While vfio-pci's error_detected callback notifies user-space QEMU
> -	 * reacts to this by freezing the guest. In an s390 environment PCI
> -	 * errors are rarely fatal so this is overkill. Instead in the future
> -	 * we will inject the error event and let the guest recover the device
> -	 * itself.
> -	 */
> -	if (is_passed_through(pdev))
> -		goto out;
> +
> +	zpci_store_pci_error(pdev, ccdf);
>  	driver =3D to_pci_driver(pdev->dev.driver);
>  	if (driver && driver->err_handler && driver->err_handler->error_detecte=
d)
>  		driver->err_handler->error_detected(pdev, pdev->error_state);
> -out:
> +
>  	pci_dev_unlock(pdev);
>  }
> =20
> @@ -330,12 +345,12 @@ static void __zpci_event_error(struct zpci_ccdf_err=
 *ccdf)
>  		break;
>  	case 0x0040: /* Service Action or Error Recovery Failed */
>  	case 0x003b:
> -		zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
> +		zpci_event_io_failure(pdev, pci_channel_io_perm_failure, ccdf);
>  		break;
>  	default: /* PCI function left in the error state attempt to recover */
> -		ers_res =3D zpci_event_attempt_error_recovery(pdev);
> +		ers_res =3D zpci_event_attempt_error_recovery(pdev, ccdf);
>  		if (ers_res !=3D PCI_ERS_RESULT_RECOVERED)
> -			zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
> +			zpci_event_io_failure(pdev, pci_channel_io_perm_failure, ccdf);
>  		break;
>  	}
>  	pci_dev_put(pdev);
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index 0990fdb146b7..0658095ac5b1 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -148,6 +148,8 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_de=
vice *vdev)
>  	if (!zdev)
>  		return -ENODEV;
> =20
> +	zpci_start_mediated_recovery(zdev);
> +
>  	if (!vdev->vdev.kvm)
>  		return 0;

Sashiko notes that mediated recovery stays true iif kvm_register()
fails later in this function. I think Sashiko is right there.

> =20
> @@ -161,7 +163,12 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core=
_device *vdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
> =20
> -	if (!zdev || !vdev->vdev.kvm)
> +	if (!zdev)
> +		return;
> +
> +	zpci_stop_mediated_recovery(zdev);
> +
> +	if (!vdev->vdev.kvm)
>  		return;
> =20
>  	if (zpci_kvm_hook.kvm_unregister)
