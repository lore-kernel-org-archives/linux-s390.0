Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71604854E4;
	Wed, 14 Oct 2026 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962834; cv=none; b=P0JbzB5LDvNqvmTcThnfVUYVTzAa9YGIDruW2sPhOOOZdQmQNSC/TX7luUbfqLOOOzxqu0hmYuXnnysBzAV9Z2Z9gIX/Nu+5MG24bEMuhPqlk9KgrZiIhyHZv3wqHaoDgBEthyMcgm9bX25XGPPhg09l4/MmLSC6dlWijt9pb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962834; c=relaxed/simple;
	bh=VNdKw7Tr+gHOk5b2dkxEQFA5QvY5C8fiERLM/lPOnm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRtHlGTiuq7md5hyC1D5yMTi+n9ZHbfuippy76W0Va4g8XcmEuyIBkM9B8h1A4V8lTJJHnFSP675jjVZTpu9ool0KBaUyRVHzO/HRb6QU3qU+nWn9JqDrk4AdKu3C3rKEjrKRnxBpNUiYKcokL6H1b7zkB3+LiGhze9QKyKngoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CGZtOtFS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CGZtOtFS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DM4RNL726375;
	Wed, 14 Oct 2026 07:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mhK2+v
	/HKN2wUAag47Lc2U5d7R2bTONbO8h87fG4EzM=; b=CGZtOtFSSgLDuK5k5Q/Ctp
	hOzRq23ogPAb1TgjoLf9sIJqUXK58M4usf2hLBCw8OMY32kuBA7WeKqEtTH7sLE7
	rhnES2ewk6CxQ3V4L96NW78LhpU2QMbI+FsI+XAooRHRv099lI5GUqWwOSPrIwmb
	4CQPXuCUkEL9Ax3CdJRyAPFlh3DKnJG4ktIC0tYW0UZmm20mURZ8LAbyVZqxnjKe
	aS1c9vTuocB6FgVGSNvJiu6exmRcfxy2lrelBxLbirnuNVuFPNryGZpyvz99A+CB
	dtipzZ8sBJ9X5CNaq9dhHesubJeNYnb1+qk5E724zQac+j76Cl1x9wYVsjWpy6Ug
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0jh7b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 07:27:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E6Bqch3943945;
	Wed, 14 Oct 2026 07:27:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypq14wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 07:27:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E7R0Wo16646436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 07:27:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC8D32004B;
	Wed, 14 Oct 2026 07:27:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0DA920040;
	Wed, 14 Oct 2026 07:26:59 +0000 (GMT)
Received: from [9.111.50.64] (unknown [9.111.50.64])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 07:26:59 +0000 (GMT)
Message-ID: <ebed4ad46283c7b34679a040b72ba3ba873dd606.camel@linux.ibm.com>
Subject: Re: [PATCH v9 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        schnelle@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        Gerd Bayer
 <gbayer@linux.ibm.com>
Date: Wed, 14 Oct 2026 09:27:21 +0200
In-Reply-To: <4d6b3e6c-c1af-4a1f-9a8b-4266f386a299@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
	 <20261007135926.82935-3-oelghoul@linux.ibm.com>
	 <722e46379f3e7825ac1d40805ae67d236fcc6867.camel@linux.ibm.com>
	 <4d6b3e6c-c1af-4a1f-9a8b-4266f386a299@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAyOCBTYWx0ZWRfXykFU3Vx8zDdI
 v3FW78z+fazMWaVeDmHkifa4pfAdonZW+6e9PSFiaoRU/cIJPP/6kZooa2yAzBjmOH2WiSzBkh3
 byqRoNgWhGBU4oJN/z/gcOPCZqGdwjihCvXtb0w6hQn8Nkbt8GQbSuVFRw8U3vlpyOdH4DMgjFc
 9kALaTWhugSjtyLvaQ2goFbmjTFBTX9rswMKfu3Gzpfg622CFJ+cC8J+royxVcgtw7Mq6EzSJLm
 rb95nMCVqf9eaWVF4QoXOrEL74f55ALhSlTVO0mxVrEd5FEpENne3RzkZigyn+GUgzELOGw19JZ
 8tX69msRZoyIMCVpiaeLoZcEFzQX3MKszxiZ+Cs+Bm9gcXS4L4vjLBrKecmRBSUx6Jhc2jdv7OX
 xV4DwYeKOp/3oHQ6iMexWR5iyeYJ85Mns57ETya3zReBIUBnltlAp3tyJFsdHRFElCga7Ahd4jR
 mE10J1raSu06Ug8xPWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAyOCBTYWx0ZWRfX/FWsNb2fFmLq
 CgqVsUCriMTspbVYzgafwvwG3xOa9ctRZuwx9OSQpyzVJ4izo61hyofma6FGMEqqfGbD8yXqVlT
 N1xThGQuP8YKuCwN4u36lYTBP/FCLSE=
X-Proofpoint-ORIG-GUID: VcYWyFREazaWZPqL61M3zp21nY0oIti_
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acf2ec9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=7Tqclk04O1Zh919NLqsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VcYWyFREazaWZPqL61M3zp21nY0oIti_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140028

On Mon, 2026-10-12 at 13:41 -0400, Omar Elghoul wrote:
> On 10/12/26 5:22 AM, Gerd Bayer wrote:
> > On Wed, 2026-10-07 at 09:59 -0400, Omar Elghoul wrote:
> > > Don't free the FMB buffer when disabling measurement in
> > > zpci_fmb_disable_device(). Instead, make the buffer persistent for th=
e
> > > lifetime of the device and reuse it across enable/disable cycles. Def=
er
> > > freeing the buffer until teardown in zpci_release_device().
> >=20
> > I lost track if this was discussed before: Would it make sense to break
> > this out into a separate patch, so that memory allocation/life-time
> > questions are decoupled from function-measurement preservation?
>=20
> I think we did discuss that before and I expressed a preference for
> leaving them in together, but since this patch seems to be growing I
> guess splitting it would make review easier.

Hi Omar,

reviewing is one argument, the others are: Debugging, bi-section,
fixing, back-porting, ...

   [ snip ]

> >=20
>=20
> > > +/* Re-enable PCI function measurement: clear the software IOMMU coun=
ters
> > > + * and (re-)enable the FMB. This function is used to restore the des=
ired
> > > + * FMB enablement state when measurement may be implicitly disabled =
by
> > > + * firmware (i.e., via CLP in zpci_disable_device())
> > > + */
> > > +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> > > +{
> > > +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> > > +	struct zpci_iommu_ctrs *ctrs;
> > > +	struct zpci_fib fib =3D {0};
> > > +	unsigned long flags;
> > > +	u8 cc, status;
> > > +
> > > +	lockdep_assert_held(&zdev->fmb_lock);
> > > +
> > > +	if (!zdev->fmb) {
> > > +		zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> > > +		if (!zdev->fmb)
> > > +			return -ENOMEM;
> > > +	} else {
> > > +		/* reuse the same FMB buffer for as long the zdev lives */
> > > +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
> > >   	}
> > > -	return cc ? -EIO : 0;
> > > +
> > > +	/* reset software counters */
> > > +	spin_lock_irqsave(&zdev->dom_lock, flags);
> > > +	ctrs =3D zpci_get_iommu_ctrs(zdev);
> > > +	if (ctrs) {
> > > +		atomic64_set(&ctrs->mapped_pages, 0);
> > > +		atomic64_set(&ctrs->unmapped_pages, 0);
> > > +		atomic64_set(&ctrs->global_rpcits, 0);
> > > +		atomic64_set(&ctrs->sync_map_rpcits, 0);
> > > +		atomic64_set(&ctrs->sync_rpcits, 0);
> > > +	}
> > > +	spin_unlock_irqrestore(&zdev->dom_lock, flags);
> >=20
> > I know this is pre-existing, but how about breaking out the buffer and
> > counter preparation/clearing into a helper function?
>=20
> I believe it has been done in a previous version of this series at which
> point we had two callers for it. Since we don't have another caller now
> I didn't think of splitting it up.

To me, the "detour" into clearing the zpci_iommu_ctrs together with its
additional locking requirements was the point where I felt: This
function is doing too many things :)

   [ snip ]
> >=20

> > Oh, and while playing around with this patch (with and without my
> > additional modifications), I realized that statistics/function
> > measurement gets re-enabled when I run `zpcictl --reset-fw <bdf>` to a
> > function - despite it being switched off before the reset.
>=20
> Great catch -- the FMB re-enablement in zpci_reenable_device() was just
> one of the two places that needed it, I missed to add it in
> pcibios_enable_device() instead of the existing unconditional enable. I
> will fix this in the next version.

It just occured to me, that if you plan to use the same conditional
enable based on fmb_requested/statistics_on in pcibios_enable_device()
you may want to change the initialization of that bool to "true" in
zpci_create_device() to keep the default behavior of the statistics
being on.

That said, I always felt a little uncomfortable with this default
setting, since it creates load on the overall system, even if nobody
cares about the data. Apparently, that default-enable was chosen at the
initial introduction of statistics with commit d0b0885316ab ("s390/pci:
performance statistics and debug infrastructure"). But that's a
separate discussion I need to have with Niklas and Halil

> re: splitting up the functions into a pair of request functions and a
> pair that actually do the MPCIFC: it will make resolving this issue more
> straightforward, because preserving the state in pcibios_enable_device()
> will require us to disable FMB without clearing its flag in
> pcibios_disable_device() as well, which is cleanly possible with the
> changes you suggested.
>=20
> Thanks!
>=20
>=20
[ snip ]

Thank you!
Gerd
