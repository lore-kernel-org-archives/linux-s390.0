Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E786213E89;
	Wed, 18 Mar 2026 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817828; cv=none; b=REZBCQHVRTyL/A4oDYozQnrw5enr2nX4enD950BUh5zgD+B6scrpKU6OyrP6KWBN2XhqZWS2TL2MdOjLPRQzqFbqbJtqY7NTAfFhfqTbwxEveU62Ss9UvulkcR0LmHKo+21z7sFi8cwAqym4FurjF9sFpTOhBL9qLXokE2EaWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817828; c=relaxed/simple;
	bh=QTi4VjDlQNNHrPydrgg7R1lbY+2K38Dx6/Rdp0SucRc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=YLg1zaY51wTeB5Zv50YAf4YGF8GOPN4I+LH97c2I3yQbdWXdfyjYyec+IvUcM71oX2SHw4I8c54NUtyZQ/sl0pbq8Hblg7J56KnL/1V0PYNYSSW3pMtqzMXNMvhli+4zifbpq3u2bEYjDgzEVbjpYI6fF5sdk28GjoB7UOCTGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T9W8SC2I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T9W8SC2I"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HKA8CX976992;
	Wed, 18 Mar 2026 07:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X5uz72
	fQmPhWY18n8PbZsSFCyYtE9oqa9WOhe2AVdJk=; b=T9W8SC2IHABMmYhHAybjCx
	hIjY0CvRsQQCBoh3B3LQ5fBRnUjQ5poPdLsWRb6UlK13D9dn3ocoAxoWQGchL2vO
	s6viXwF9nKYC/kc+HA7P5Ac3R+xzA5uYwvyyNZT7rjPsV3MwFaTYE0iZX9xwXNz6
	/+79d2dUm0IMBCGOKu0ukNvlPNunXgBTzZei72IbdAMS46g1nBOsw8QwXv7a4s15
	vXDQP245iBiuS58egPxs97GZ7hUh7m3NqzoCIrSPYJCP53WT53LxlsDCbxVQ9eiH
	r0F2h5BOmHg54+VhmFaPIq9GHgnpUB/4rdTWdlYqbYLiF3krnQW8lSpRuG9CWi5A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d02y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 07:10:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I644CP028496;
	Wed, 18 Mar 2026 07:10:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1cmtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 07:10:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I7AK2Z49152396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 07:10:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E14CE2004B;
	Wed, 18 Mar 2026 07:10:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD59D20043;
	Wed, 18 Mar 2026 07:10:20 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 07:10:20 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 08:10:15 +0100
Message-Id: <DH5PXQZ9JRY5.RPLRAKRIRMCO@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 04/10] KVM: s390: kvm_s390_real_to_abs() should return
 gpa_t
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-5-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-5-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69ba4fe1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=5VlVqv3a4dB1-NjogH0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA1NSBTYWx0ZWRfX8TYXJgxwS5Wj
 raL8Lz+mv9JH42gFvzNAfIZBaUkgAXiFodDfjhDJpjxRYd7WuRbTGQw4PK2YQIwVOmONdZ6Gq4N
 cf3TOaixB5z7opRfu0NSlWYW43S0qSYt4shFyy+7l9dhiIZpjPwSuNgOqMUtPuLmwk5vO7IKx/F
 WL/8H6vrWZ2msOa3JVCdwmvwmesb1H6gofTalh/lNPCk2o1Vo5ZJPjZP6+l9h/9FIAqpgTsGm9i
 iuwOBXprB04pWqRlNicZeghQ6qv4RKyIPWo/K4dmAu/VCa8EnDiENnsNHgaGmSIQJjp2RGBgryR
 BS6wjHOo9oSt9GQlQnnndpaYElwF/b/4Qwrpg5lZ98BD0TDcWJMSoKbMzLpGi+1+ETuAnWvKKS7
 /amLJlsf0TbuLqLDApNorU7jS4cGn7i9lSqsRCytdatgbnPkMm+mnnyDn1L2LlkeKJDTk77NYQc
 BDrs1CoBus6KcMZml5A==
X-Proofpoint-GUID: QxZalVXq2k9Iee5MfLLBtSz4WtNdUUCQ
X-Proofpoint-ORIG-GUID: QxZalVXq2k9Iee5MfLLBtSz4WtNdUUCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180055

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> An absolute address is definitely guest physical.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/gaccess.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index b5385cec60f4..ee346b607a07 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -24,7 +24,7 @@
>   * Returns the guest absolute address that corresponds to the passed gue=
st real
>   * address @gra of by applying the given prefix.
>   */
> -static inline unsigned long _kvm_s390_real_to_abs(u32 prefix, unsigned l=
ong gra)
> +static inline gpa_t _kvm_s390_real_to_abs(u32 prefix, unsigned long gra)
>  {
>  	if (gra < 2 * PAGE_SIZE)
>  		gra +=3D prefix;
> @@ -41,8 +41,8 @@ static inline unsigned long _kvm_s390_real_to_abs(u32 p=
refix, unsigned long gra)
>   * Returns the guest absolute address that corresponds to the passed gue=
st real
>   * address @gra of a virtual guest cpu by applying its prefix.
>   */
> -static inline unsigned long kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
> -						 unsigned long gra)
> +static inline gpa_t kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
> +					 unsigned long gra)

nit: This would also nicely fit into a single line (<100 c) when you are al=
ready
touching it.

>  {
>  	return _kvm_s390_real_to_abs(kvm_s390_get_prefix(vcpu), gra);
>  }

