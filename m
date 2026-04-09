Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB2337BA6;
	Thu,  9 Apr 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742122; cv=none; b=iotns5SEqQGvNVuwx7oCByDQZleJ992sRIedYmBRgSIeY52DzEGuU/Fke+RA4a5/JBaBz1DtfqPBkwYrCyz/TyFHr7FDBaQ3GvBTtQcCJ9+pLAhf5RruElHTHKfNZuQpJseSXAoatYI1IQ4a2Bu83sLL1DkdRvOp2JsITp1lzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742122; c=relaxed/simple;
	bh=npuzu5k4rLfFUFlfrZ0kqWcRCSC4ifjCJBl9lJesS4I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=OG1aDXEFr63kcAhD4CKwFOoqcqWY4UXe9WVzFgmAo3Ts9EoD+vOxnUfsOM7lx4qcrq5UDO6b+3pdPz/3OImEbPfi8AS+FbvONa2x+PX43ka27FtzhGBbZfAgjh2Ic9mqLiRJrahMPQbBDxCT16nX9oaob1hQxB32b8yBQPA2qrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LrsNMClI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LrsNMClI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639BweOQ2325942;
	Thu, 9 Apr 2026 13:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GhCFHx
	evcN1EulnNMWEpaBv/BTT0Mwbz5NYh83QfENY=; b=LrsNMClIv+lfxYPCMH2xpa
	2baYtyFZbaUPoNm8ESwErqVpOPZeFeaZPi33yQTzHLW7Jfv/FfFgi+7AT+laSFmM
	TaeGGH25ySIAZyoayRMVVNKuoH8QIb10cMdMEK7aRjS/lHZXYureohGeVxOw6Rmq
	OJ6whFUqwUtaOvZs8BGKNJnlo4KdojRU9GG9whZe0XGwGwHVmllFPpsrs1xUuo8q
	34Vuk8pAQ4uYtuKr/3tACwqNEy598KpAwb/4F2JK1rGLt2hTdX0urY+vLHxuPwzz
	MTQDt2OIJdzoL8OreXl5okVPfBLX6lUa3zfMYJ37UsYJIX73hPjgTglg20Fbx19Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kmay0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 13:41:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639CtiCu030025;
	Thu, 9 Apr 2026 13:41:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7ks0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 13:41:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639Dfr5i30999000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 13:41:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A3B42004B;
	Thu,  9 Apr 2026 13:41:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C9B20040;
	Thu,  9 Apr 2026 13:41:53 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Apr 2026 13:41:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 15:41:48 +0200
Message-Id: <DHOO1IO9TJ05.VP8TRR0IC58W@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <nrb@linux.ibm.com>,
        <seiden@linux.ibm.com>, <schlameuss@linux.ibm.com>,
        <gra@linux.ibm.com>, <david@kernel.org>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] KVM: s390: Add some useful mask macros
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-2-imbrenda@linux.ibm.com>
In-Reply-To: <20260402150135.196943-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEyMCBTYWx0ZWRfXz4PBRDX4MxrH
 GnWQHaoS0u3umQH0HC6jENQljWMdD8dJFM88ERy0NDEsx17ddm0dtk48ncENfAdjXGhatw1npio
 2oXoQU9XDcLy2iOYZ8CRvpTaAb+kU+XuBGTmzyaxZ/k0sysDtoGLzE7V364z3FlMLLVjv2TwQdB
 633XyEC71/IF9jmHKIYl9O+JTz0Y6RVM05uHFxrQbzX6uH4Wj0VOqyjWXGrRtMWsg/Pm+1AKcmu
 Ou7kEA50SK6EOqHX/6yQkTiavC+ftjL9TmDQRBOhbq51jYEDZK4LfKjQCjJ4kWm5t0vRa7w5Oyk
 jsLGkDbRYl/pkBepGXELNQcuHrkEp8uCfZmAJ5MzgpDuyX4je8qgajoIX6JvvXV1+mGDBWlcai4
 gSm805GK2XNm1lExp0uNlNayzoiiL2wIiNWXU0a2MT/Wct5uBoBhsb1D018/TitrYBI8B0M2scl
 1k6Z6e1bmufcmc8QiUA==
X-Proofpoint-ORIG-GUID: 9ItTmtwYld4Eb5CgUcYdA7YLVSnO-CG6
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d7aca6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=vf6NJk7m3_Ogz1M4-hAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9ItTmtwYld4Eb5CgUcYdA7YLVSnO-CG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090120

On Thu Apr 2, 2026 at 5:01 PM CEST, Claudio Imbrenda wrote:
> Add _{SEGMENT,REGION3}_FR_MASK, similar to _{SEGMENT,REGION3}_MASK, but
> working on gfn/pfn instead of addresses. Use them in gaccess.c instead
> of using the normal masks plus gpa_to_gfn().
>
> Also add _PAGES_PER_{SEGMENT,REGION3} to make future code more readable.
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/dat.h     | 5 +++++
>  arch/s390/kvm/gaccess.c | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
