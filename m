Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE12D876F
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221061; cv=none; b=ATrchJcg58CsIo6xB6xbr7XbtWPf/FakOW7dF1WrTws71yBgm/higvX6IMNiaxCy3X4I55yrqA3Hn+tuGZwNc6krSelToBI9En0A22nOdycQ2BBqXs74rNvr8Dt1BE7ihF4QhktitxnwPJzWESYx3cs1l0S84g2RI+1Aln5NzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221061; c=relaxed/simple;
	bh=gozI/5fSs1m2OOHhyS41Zf8tQ4K/OeURXlpnKKKgkh8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=H/fonNPkXuU7sMcYq5B+t8mCMhov/ymbqs85Gq0GnrFgDDtUGWdtuKixfhJgj0+ThVZvl8Z3wl9n5D0+zCU6QOqfpFtUN4u1hyVK0nYgNFxO6Gk4h4luFkwlshYxFbbTwe3nr0dJtgMpvtCOLjN2NeN0FhPPojCbW0kz2SfRV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cyNnsDF3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cyNnsDF3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBn1u61858416;
	Tue, 23 Jun 2026 13:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=on+0QBgqn0KWED0Zji4ZXL+ApebeYMnDHgGTNc+b7Hk=; b=cyNnsDF3xNGC
	bmJgPP0oNW+Nx3TW/qMFIOuQDZu71/rQiM/XEa+asP7qh3Ycjz+8yv+gtjtj/QY/
	zfm6UL7ojTqgKlFZz+SjICSkDRUU+kXkBiXROqyiQ2/RJCyg4xZNUgWFnXRUGoX0
	0pcM9JIyeTThSSbYKAJ9PtDPjHIaQaDVdEdd/jHau7gxuGYrdb0PwSnf9ESGY9uv
	qNFHN5IRNlmMwgn44owtf2Ik1ZYEPSOaLNX9mntIcdnVJJZuj6KqwtPbX4mMyti0
	lnrzlVIigICo+kQOwYzdXaiIkV272zXL5c5PvgzLZaCGAHHTB7oR6moSp9F5e+Mg
	pqIX/KPyqQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hpx5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 13:24:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NDJe30018678;
	Tue, 23 Jun 2026 13:24:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qbmn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 13:24:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NDO2Gv46662082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 13:24:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB275805F;
	Tue, 23 Jun 2026 13:24:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8641E58054;
	Tue, 23 Jun 2026 13:24:01 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 13:24:01 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 15:24:01 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 16/17] crypto: Add aes-helpers file to support some AES
 modes
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <b8f22f51-2613-4213-a5a6-d6525b9c253e@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-17-freude@linux.ibm.com>
 <b8f22f51-2613-4213-a5a6-d6525b9c253e@linux.ibm.com>
Message-ID: <a83b80f1c5dfb9b37bd2786667a8960a@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ce4kH9BbpJPCbCiOmZpTTtJCgXZk4-hP
X-Proofpoint-GUID: ce4kH9BbpJPCbCiOmZpTTtJCgXZk4-hP
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a88f5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Cxrpp1Ua33vx6Cnz8XsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfX0eRgMEppypHB
 Mv3UtIXUfT0L15quEJFt1k8pQkesgHvrh75U2y0A16uIrp1bWplPluFElYQe1MeiqqZWBd6sC3N
 OSxNT2EZgViJpETOOA3cOGV5vVKZKw67H4OZMJlvfDGFouIqwbavGeDYWhM7hg6ftbC2tydPffy
 s1fGp1TUXekejLou6pbAdqkExBLoEdIZHCeWuUW7Rz1UM0RQwiEOmBXp402jPsKwGl0uJFplKZV
 B8IYv+4iL8+GDXcT0jwtJV1ObVihN8+zfKN0Hi/lM1TPMpAn/b3Qq08cT20aANdkIywHYTyQqiE
 4gJe9QbbPy7kDktTFk/VXkkKuHILDHl7bRB9X3FfVE2W7f7bMuI7e5edRMWtVxWZRtLsSgEExzS
 Y+yuNZxiehbnI3W9aT5Msax0NOcfdPhO7g7txBNspnMmi/SUtm1rsqx/mGPyX7NnUNj+lmNBM5f
 x5BjGyKMCCtjNteLXcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfXzNta9Ch6HFEF
 EYDLNBR0k2lBhWH7XHM3rAg3LKwy4hXTk2jU7KgVMe1YRjAE/0LKrws1tpORqS/POzwW/iCE9lA
 OTxxkLP2wtIiLdps6gMRVwIA+JpBDVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230109

On 2026-06-18 08:31, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Add a new file crypto/aes-helpers.c with simple functions
>> to support some AES modes:
>> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
>> - AES ctr: AES_ctr_encrypt()
>> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
>> and some AES related helpers:
>> - AES_xor()
>> - AES_xts_prep_next_tweak()
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> I like this, but why do you do this so late in the series instead of
> implementing it directly like that? Otherwise:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

This was a suggestion by Holger. And I want to have this separate to
be able to remove this and the next patch without the need to rework
the implementation.

> 
>> ---
>>   crypto/aes-helpers.c | 101 
>> +++++++++++++++++++++++++++++++++++++++++++
>>   crypto/meson.build   |   1 +
>>   include/crypto/aes.h |  14 ++++++
>>   3 files changed, 116 insertions(+)
>>   create mode 100644 crypto/aes-helpers.c
> 
> [ snip ]
