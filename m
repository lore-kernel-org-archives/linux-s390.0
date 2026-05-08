Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A3399360;
	Fri,  8 May 2026 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270379; cv=none; b=HUe5vmoe6k7MKgq3ehgFHiKP9IRO2Gq5Rpg52ZBi6z+E1As95DPOhLAw5MRASxut8doKQ/EPHtrAOs4zXvx9evtWyF/O/PpiJ2UENyuWO1uzReodrh/fgyTaz+gzvO4d7SLC+3k+mXl2VxsYAIXZotyGFwUGV1C+HREdnAdd0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270379; c=relaxed/simple;
	bh=i/6BIyQF4NUWorA6rHkE9B/zgwZWJke+0pbw9+H3RmY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=pOqBFxA4k7r7Dg2hAoFdBqkFr1lgSTZea+WYWWtivu77lXInfQbq1sjVS1vpzidahrJTBbzHYFzjBUgBgCwL31Nqq4IwpN5Y0rApwpba1SyDPeBCxSQLcO7yG8skYBEVYyyVCyPPfxgKil/0g0elH2Ba+xo5BjCNueYa7ldPzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ANpeJB8z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ANpeJB8z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648EJqYc3352136;
	Fri, 8 May 2026 19:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ns4sNy
	zDyyr4NGEvO0pRp5U4Ka6peQezTAybSHCQuO8=; b=ANpeJB8z3d6FWkINMJSPfj
	iDPbTz8rk/4vm8fWV0DAuc4TiNBGBq6baZ+gv1LRtlJU32hUryFULAX4ftJdCbAi
	k7G/nwZRyPJqcqtR3nXKBE6brFVEJleW3F1xUuZW+T/reNgZB02dMyJMG0wbPKBK
	erxbufAjorA9N0zJ0ujiwMPnTbEumANV+EGhQWic8eheeUtMEk144Ui9Q4qdXd8N
	KgRHbrIhSZRM6UTYKgGGwtV18oDWoDJAvsktlfNOBWorhEYCytJRgayERxndMxVf
	FhDFQdkaUKSFpc+MwT3+l86Z83lA9Ieqoj2dK5VbEvZ+ifMmYdEFGTgQYQVs8fyw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy40sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 19:59:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648JsidP030481;
	Fri, 8 May 2026 19:59:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgsj3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 19:59:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648JxRrJ26935902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 19:59:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA08458053;
	Fri,  8 May 2026 19:59:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38CFA58043;
	Fri,  8 May 2026 19:59:26 +0000 (GMT)
Received: from [9.111.88.123] (unknown [9.111.88.123])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 19:59:26 +0000 (GMT)
Message-ID: <6dd6de60d72a70ff85ecab2a9d14f45a617f05e7.camel@linux.ibm.com>
Subject: Re: [PATCH v15 4/7] s390/pci: Store PCI error information for
 passthrough devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
In-Reply-To: <c4bb6240-e29c-4ed0-917d-47a0d21d4c11@linux.ibm.com>
References: <20260505200510.2954-1-alifm@linux.ibm.com>
	 <20260505200510.2954-5-alifm@linux.ibm.com>
	 <24bd0f694b2bddf07450e09fcea0488ee42ccdf7.camel@linux.ibm.com>
	 <c4bb6240-e29c-4ed0-917d-47a0d21d4c11@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5NSBTYWx0ZWRfXy3qTrkjHA47D
 uOEYPjECGpI0rBOItERXQih8fG51f2N3FaqVet3gDmWGRS8h6Q0s0Fc+sWq2S8g6+nuvlcX1i8t
 NX54orD51CKseHNTN4i+n32gEuax/g6JMK0mnGic+winCtSnXwq7xINBM8QCLAt6l/wGYqbbB3h
 cWNNbRr0VTvPiJgtUXQDpo93HkPRgSxJ67UBr+visbFxX9eaxTrkjGt9B/YynboMaiCGloKYsiz
 nA0FjbC+xY+Fby2ekAwKWq9QClr04Dzx6dH9kAwmgbp6Tl6vzVCUNSVhVQ+XLJBEJhvSO8bav9C
 oArc0qP2zxUvbc8fnrnHlk2xvcHFTKnGPqvrjLuWOIG5A9EavxWgNjygm8hgaLQ6pii8Op7vABv
 nMGurAt8Cll0e91/PSfb4uGR3p7jiRY6aAnjYi2mX+MGX45JZPWhXP7suiyxhlFdZh5jQSmR+eQ
 +EIUG5/SzW0nlH3mB0Q==
X-Proofpoint-ORIG-GUID: CTY0E7fOD5NJAnx3DbbBeSzn4_fEsADr
X-Proofpoint-GUID: CTY0E7fOD5NJAnx3DbbBeSzn4_fEsADr
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fe40a2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=j8X9kYvwx1WCCqF5fZEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080195

On Wed, 2026-05-06 at 10:20 -0700, Farhan Ali wrote:
> On 5/6/2026 2:38 AM, Niklas Schnelle wrote:
> > > -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci=
_dev *pdev)
> > > +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci=
_dev *pdev,
> > > +							  struct zpci_ccdf_err *ccdf)
> > >   {
> > >   	pci_ers_result_t ers_res =3D PCI_ERS_RESULT_DISCONNECT;
> > >   	struct zpci_dev *zdev =3D to_zpci(pdev);
> > > @@ -194,13 +206,6 @@ static pci_ers_result_t zpci_event_attempt_error=
_recovery(struct pci_dev *pdev)
> > >   	}
> > >   	pdev->error_state =3D pci_channel_io_frozen;
> > >  =20
> > > -	if (is_passed_through(pdev)) {
> > > -		pr_info("%s: Cannot be recovered in the host because it is a pass-=
through device\n",
> > > -			pci_name(pdev));
> > > -		status_str =3D "failed (pass-through)";
> > > -		goto out_unlock;
> > > -	}
> > > -
> > >   	driver =3D to_pci_driver(pdev->dev.driver);
> > >   	if (!is_driver_supported(driver)) {
> > >   		if (!driver) {
> > > @@ -216,12 +221,25 @@ static pci_ers_result_t zpci_event_attempt_erro=
r_recovery(struct pci_dev *pdev)
> > >   		goto out_unlock;
> > >   	}
> > >  =20
> > > +	zpci_store_pci_error(pdev, ccdf);
> > Sashiko notes that zdev->pendings_errs.mediated_recovery could become
> > true between the above zpci_store_pci_error() and the below check for
> > leaving recovery to user-space. I think we could make a general
> > improvement that also tackles this concern. The ideas is that we could
> > have zpci_store_pci_error() return true if it did store the error and
> > we are in mediated recovery mode. Then we use that as the signal to
> > skip host recovery below. That way we also don't need to retake the
> > pending_errs_lock which makes the below much simpler and it would be a
> > win independent of the race. As for the race this would make sure that
> > we either do the host recovery or store the error and let user-space
> > recover.
>=20
> I did think of the concern about mediated_recovery becoming true after=
=20
> zpci_store_pci_error(), but IIUC in that case we won't even be able to=
=20
> deliver the error signal to userspace (via error_detected()). And I=20
> don't think mediated_recovery flag can be set to true. Since we are=20
> holding the pci device lock, vfio_pci_core_enable() will fail as it will=
=20
> fail trying to reset the device.
>=20
> Thanks
>=20
> Farhan

We had a detailed internal discussion on this and I think Farhan is
right that mediated_recovery becoming true between zpci_store_error()
and the below mediated_recovery isn't a concern.

On ther other hand one thing we do think could happen is that
zpci_store_pci_error() finds mediated_recovery true and stores the
error. Then a vfio_pci_core_disable() and thus
zpci_stop_mediated_recovery() happens and by the time we check below,
mediated_recovery has become false and so we store the error
information but then still proceed with recovery in the host.

I believe this is related to what Alex raised in the past about a stale
mediated_recovery. Now my thinking however is that we actually do want
to use the same "stale" mediated_recovery value below, as we did in
zpci_store_pci_error(). This is because this makes this case behave the
same as the inherently possible case that we store an error event and
then the guest just doesn't do recovery before the device is hot
unplugged, the guest shuts down, crashes etc and the event is left
stored until zpci_stop_mediated_recovery() and then we get out of the
error state via the next reset. We also investigated whether it would
make sense to handle any left over error events on the call to
zpci_stop_mediated_recovery() but for now that would get rather complex
and we should get a reset before the device is used again. Also while
the device isn't in use it doesn't hurt for it to be in the error
state.

Overall, I think this also makes the reasoning simpler in that any
error event which arrives between zpci_start_mediated_recovery() and
zpci_stop_mediated_recovery() is either recovered by the guest or left
for cleanup after zpci_stop_mediated_recovery(). So I'd like to still
go with the proposal to use the mediated_recovery state as seen by
zpci_store_pci_error().

@Alex if you object to this or see an argument we're missing we can of
course I'm fine with going with the approach this patch took.

Thanks,
Niklas

>=20
> > >   	ers_res =3D zpci_event_notify_error_detected(pdev, driver);
> > >   	if (ers_result_indicates_abort(ers_res)) {
> > >   		status_str =3D "failed (abort on detection)";
> > >   		goto out_unlock;
> > >   	}
> > >  =20
> > > +	mutex_lock(&zdev->pending_errs_lock);
> > > +	if (zdev->pending_errs.mediated_recovery) {
> > > +		pr_info("%s: Leaving recovery of pass-through device to user-space=
\n",
> > > +			pci_name(pdev));
> > > +		ers_res =3D PCI_ERS_RESULT_RECOVERED;
> > > +		status_str =3D "in progress";
> > > +		mutex_unlock(&zdev->pending_errs_lock);
> > > +		goto out_unlock;
> > > +	}
> > > +	mutex_unlock(&zdev->pending_errs_lock);
