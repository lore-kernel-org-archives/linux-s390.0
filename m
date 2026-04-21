Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAC20E334;
	Tue, 21 Apr 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785437; cv=none; b=Jbn68X9FVptH+Wq0Ran8829hxJBC5FyOr4Ht7fxQxicydlBbf6G+vpMRAvk5Q/rJfggt3/lpWJ08x6vt6i4y5duU4m26dcGO7o9xMuri0MYF7NtCm2U4XbU1+NOK1RsCzjJaNhcpMjNwt/Y8HwVqFrUioD1ZV3brfVecNOrffRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785437; c=relaxed/simple;
	bh=Bg6LAYGjyxnnXdl9A1ZI9clC/Jbo/rruC+RF+6hEqx0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=nRIH1Bc6zprG0vO0hsVTOfBvNRQA+Hr+udIum+Q8irLd1xfEQXr1ljeAzP2kec6x6SEbVpjhoasC+2RIygx9SnBTyAA3bV9//dk84Jw2uWiQSt7Ndt1PN8Y5CzNdTMmh4rv1DJin/z1QhhplRzwSKXpL7zD6044lfixIBjUuGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ny3PHb4C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ny3PHb4C"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCXId31687200;
	Tue, 21 Apr 2026 15:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sWesfd
	y0asBETUXlAzoNUNBHebaFOS4T9Aif6iCmFak=; b=Ny3PHb4CdrXIXCla4e3oS2
	muQjOK19Q02ZTZ34oN16bcTuGJWfad8KFzaM8ZCO3PCO24cgyfgaYk0Dt1iJCg04
	+lTAK3uF+CyKOPvskv+wg8/aS2ty/5bvyOCQV1Vr1mZE8Vz+8n+EuM2ghg4I7XvA
	EG1rWV/LRQnkVYaESzj5BjJeghcu2lmvPo2KdnaHjD6wSvYI+pbGayx1zGWRItMR
	gLUMXgeumf7K861b0dXDzP6dWARBlewURao/iW/dPjMcDkRjUhlSeZYe7ccchRmK
	5FgidfXl0p/V9QLimQzKZqIb2YV6OpCgtiPGPcCV/wNCZq86AnvN0Zyh/jigXxrg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6n0as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:30:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LFKLTL003666;
	Tue, 21 Apr 2026 15:30:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy10jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:30:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LFUUnw40894740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 15:30:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD0A20040;
	Tue, 21 Apr 2026 15:30:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93F602004B;
	Tue, 21 Apr 2026 15:30:30 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 15:30:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:30:25 +0200
Message-Id: <DHYXV833VJC0.8NBWBY4RFMD@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 4/4] lib: s390x: snippet: Add function
 to create a guest of specific length
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260420084933.251244-1-frankja@linux.ibm.com>
 <20260420084933.251244-5-frankja@linux.ibm.com>
In-Reply-To: <20260420084933.251244-5-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1MyBTYWx0ZWRfX+NH0fhO+rVk9
 XK5SGL4+YFEBzokvl9V/dcLihzD/PY1dOpzYyZpQYraB2p6xVGUWgg2jYDED2QPb5CEQNo9HH4Z
 uq/6NQsaUcDOFXVLV0+KvMtoMxi42G0eH+OseWDWR9wpar6AxCM6PLH3O4Qf868bsDDEAO4IbXx
 +dAVnnMZTzmyfmnyJhKfOIwW2FfdZss9hPNtF0Bp7ZqdKiRBOyThEZqia5NIooJ1Z5bMPZiHC5R
 WAJvnQyxu9JIfmnTtpm8lNXbD90NFOSbIDTpx1UPKZWFqtDg6JxlPOlSZSfCsCcCxEVUvXoICZ/
 +7QR8nSiMNq4a+wzlucXYefY0MHy6AFIeWRq9inZKFlwL8swC/bbWifrqYh0RLzaiS073ufltkH
 wA7Nc7JCBzs34+mo7PnpPcLM+QEnlIW/Xzl0bhIw81kqRD0m3y/q4bwy7rir6AbxtRFqtCknTTf
 r+qx3y0QolZoDYFCyBQ==
X-Proofpoint-GUID: BD5PqHm90p4LkJ-yX1tgWuY8kaSknV8X
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e7981b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pY8lCkV0ujk3ZHEi7xEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BD5PqHm90p4LkJ-yX1tgWuY8kaSknV8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210153

On Mon Apr 20, 2026 at 10:44 AM CEST, Janosch Frank wrote:
> While 1MB is certainly enough to store the guest code, it's often not
> enough for memory tests. Let's add a separate function to allow
> arbitrary guest sizes.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Nico Boehr <nrb@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  lib/s390x/snippet.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
> index 94688f49..05c9a2d4 100644
> --- a/lib/s390x/snippet.h
> +++ b/lib/s390x/snippet.h
> @@ -123,10 +123,14 @@ static inline void snippet_pv_init(struct vm *vm, c=
onst char *gbin,
>  }
> =20
>  /* Allocates and sets up a snippet based guest */
> -static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
> +static inline void snippet_setup_guest_len(struct vm *vm, bool is_pv,
> +					   unsigned long len)
>  {
> +	/* Guest sizes are specified in megabyte chunks */
> +	assert(!(len & ~HPAGE_MASK));
> +
>  	/* Initialize the vm struct and allocate control blocks */
> -	sie_guest_create(vm, SZ_1M);
> +	sie_guest_create(vm, len);
> =20
>  	if (is_pv) {
>  		/* FMT4 needs a ESCA */
> @@ -141,6 +145,12 @@ static inline void snippet_setup_guest(struct vm *vm=
, bool is_pv)
>  	}
>  }
> =20
> +/* Allocates and sets up a snippet based guest */
> +static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
> +{
> +	snippet_setup_guest_len(vm, is_pv, SZ_1M);
> +}
> +
>  static inline void snippet_destroy_guest(struct vm *vm)
>  {
>  	sie_guest_destroy(vm);

