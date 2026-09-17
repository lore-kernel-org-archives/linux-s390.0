Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4D501F53
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651315; cv=none; b=ArOZ4pjlqKPhDkFKz3ncOrbw+U6/6M0JxWcTuUlJDoEqsGcIThkCWJZ79VgieJTJwGyo3EHFjMC0ziJ1knMetCARgTGV7lkiCEAS/AcQbZ6sXMrhemeaPqktA/jsAri7TDFIBISXFyxxxatBgkCUY3BttDdnE5+RYBpw+2SFkoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651315; c=relaxed/simple;
	bh=iw0o8xMNEbdh75zttcY8Ic/rV4Hlj01CJqj+7kFkWUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KWWzKO47XJ7Bcqa+EHuf7++IXIIHM+jWEsBurkbPepW0DtgqF+0Ca0iCAQ+sAYPTWBh5khDvJnzvBZkZwqpT8z1YOrtVUBBcdaepqC7QwWA2WjVj4y0lOpkIk35C6TlJjIDFnY6gajE9lD6WLmk52ymJXEcNhzimW1fnQ6ANNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X60859db; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X60859db"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1ZBa2232883
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 13:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qHVHGZSqk1J2SpynbwgBSSjbeZJpZs
	hqR9H5uhsXMXI=; b=X60859dbakZU+A3GtpfUEIMEj4Iv3sx3gVZOjUwIm0i8Qt
	Ns0Jvue9XN2e58d2PyKovds8dFqVnnpSp8fuLVjXhIFVknxe+OiPXYeLy0khdwo5
	4Uf7wQ2J0dHNTC6AfMWYny2f09nKaYgUnAQQ0DfiAOkKmMDLnQczCu7l4L6Sm2V+
	2K6oQd/0lroV1uBsEUgajI1ksZnX7dNSyQUculZDjRGSS41V/n5d/sau5qQSc3KR
	REL9GAbn0sJIj3yVOP3iMsSUuT0hbq+IYfYeEE6eWCV00SUl6Xwyw0JvFDPszAUk
	rOhx0g7hFz2FAPM6IYXnBqUPs3n8KfcmN0FR6ajw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcva2av-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 13:21:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aSwH2962448
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 13:21:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yskvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 13:21:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HDLj2G32309980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 13:21:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BA752004B;
	Thu, 17 Sep 2026 13:21:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19A9920043;
	Thu, 17 Sep 2026 13:21:45 +0000 (GMT)
Received: from localhost (unknown [9.224.74.101])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 13:21:45 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/4] s390/sclp: Introduce macro sclp_gds_for_each()
In-Reply-To: <d007f6ba-19a4-428b-8973-b54c02bbfa57@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
 <20260917065824.2858737-2-egorenar@linux.ibm.com>
 <d007f6ba-19a4-428b-8973-b54c02bbfa57@linux.ibm.com>
Date: Thu, 17 Sep 2026 15:21:44 +0200
Message-ID: <871pasdndj.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE4MyBTYWx0ZWRfX3vbWvm4gLwdB
 9e7GbpXvysvMXvo9qY1KIOfMtQHxh/BC5SHblk7jkZ3XqvfHAFmu5OPTV/ECvxJWRtQQ5gYNE2d
 UuZ0DijdQzlcnXKlo7GrS4AHPT9Kius=
X-Proofpoint-ORIG-GUID: AEb1gLBhXCXsoAyYN-tRscgEnyr8plZ4
X-Proofpoint-GUID: AEb1gLBhXCXsoAyYN-tRscgEnyr8plZ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE4MyBTYWx0ZWRfX6abLYIaNXKAD
 XQ1zuBOj7vbf73O6hc63kASDMzuqqyh/ch2rVNaniwEBO3tHdFR+FjYu6WSf9M4l+Ae+KhH6GYi
 6wh5Wtx3Kzu42uXKjgT4pCeoc3fakm+KyLrHGgQ7vywe9n6kgWF/wJ/S40fhVhfH9hWvl5sbEX1
 IsB7LSgC6pQzCsYZSDSM2bEsJ7Z4jIAQDGXVcw9Ge3AILV1B1wiMarwOMpThuOCSSnXCEj4AQ5v
 qgeuszV078SnB7UChe9ZtoTwmkLDMtv5vNNN9BqIhc0BI6ZYxpQCf0+mgJx08awzraFJBsbN22n
 GL/6A6tQVxgo0T+VtTNNpbU8c7TYbvG8D1iIOWcMK1jqQn0ROzlbVZ3V+dpZm92l89zC2AsaYzu
 swHlVt7ko5wqFLWfzNkV9CMV21C1zCKgDdrxP8FsoRyu6C/W/hllb2aORyt2fE4++zxHSclcbq0
 DNpV1MM1wDB4LTXUUQQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aabe96f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=prG_liscasyCjDn0nwsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170183

Peter Oberparleiter <oberpar@linux.ibm.com> writes:


>> -static inline struct gds_vector *
>> -sclp_find_gds_vector(void *start, void *end, u16 id)
>> +/* Loop over all GDS {sub}vectors in a safe manner. */
>> +#define sclp_gds_for_each(v, n, start, end)	\
>> +	for ((n) = (end) - (start), (v) = (start);	\
>> +	     (n) >= sizeof(*(v)) && (v)->length >= sizeof(*(v)) && (v)->length <= (n);	\
>> +	     (n) -= (v)->length, (v) = (void*)(v) + (v)->length)
>
> Since "n" is likely never used by caller-provided loop-body code, would
> it be acceptable to define it as a loop-scoped variable, e.g
>
>   for (int __n = (end) - (start); ...)
>
> This would remove the need for the caller to provide the variable.

Unfortunately, this makes all loop-scoped variables int.
The v variable would become an int. All variables in the for-loop
initialization statement must be of the same type.

An anonymous struct could be used here but i was not sure this would be acceptable:

for ( struct { int n; typeof(v) v;} __c = { (end) - (start), (start) }; ....)

What is your opinion on that option ?

>
> Also an explicit cast of "end" and "start" would remove the need for the
> caller to ensure that both parameters are of type void *, i.e.:
>
>   for ((n) = (void*)(end) - (void*)(start), (v) = (void*)(start);
>
> This would remove the need to add local void* variables as is done in
> patch 2, and reduce the chance for callers using a non-void* type
> parameter that would lead to incorrect calculations of "n".

This is a good point. Thanks.
