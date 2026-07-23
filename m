Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE647F2C4
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808414; cv=none; b=h5+fWc3GMiBH/HsFTUiMYkabDNmS48I6bYtZL2MiDM91EVp7fFuAvCSGsG7IDSpSkyZbpL3oTLferSzkpN+8FWrCqqWsi5OVNodhLNjgP6TJZqvP5uBDz7jIeeEWFRhuOM+hOlLcIs6ofu0ZCcP20U2tWbRAFZWS/UmmsNcwC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808414; c=relaxed/simple;
	bh=XymYl9vW/tttGMfn7YfZiaIidFz49INpA26y9+eC00M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nuMXNp52XDkWCUOYE6xBFcyq6s3wIRIZPt9RXA5lxgB+aq0VxycnutNzA4ViheLKRrbfuinMuubieLAmC0/bFFTqatwG4SaUGKgxVBfJ9rMCUN+VtcdgXfl0Oqvp7nglCG0UEZKGPD8JoXuaYrn24SYNBCGEVs1A3bzepIX9xfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qPIOyluA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qPIOyluA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BeqC2580272;
	Thu, 23 Jul 2026 12:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=zAfVjCGDd06uVWfIK0kuSd/mt2h4cHY1dgjHgPLWep8=; b=qPIOyluAFDra
	nOev47nwYZZ3ddWiNF3USp52cr6HtdLJcITJJkb08etWG8oHoUG6THk5HxTYRGDR
	Tj4U0TYDPVacJWYz0sIV1MsydXka7K80cZ/FfSP65A/P70pIoDJTlHkjPfn5Pgn6
	JG3eA78jVx8dY087T7Lyemey/OPvIu69LhjNP5tYHeTy1n2OX8L3ljEjNGbiAsYv
	wvxYPlCkIKyQNu3/rEtL6TK4O4J3nigjAy8ovvsd4DQ8j1SJ4a1rgfBuLdPoAjrz
	1ZBTb1wH+DDtcEThf2QEw3rJxHtR6zKMHw+gyGvsnE+YwGACj6jDPc8WzcSzRFLz
	3qLR/bhRIQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abqce4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:06:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NC4dmS010256;
	Thu, 23 Jul 2026 12:06:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk40ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:06:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NC6Yjm25231998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 12:06:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66C6B58043;
	Thu, 23 Jul 2026 12:06:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C03EA58055;
	Thu, 23 Jul 2026 12:06:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 12:06:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Jul 2026 14:06:33 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v12 17/17] tests/tcg/s390x: Add tests for CPACF
 instructions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <33187980-d8d8-43f4-a138-34c67fa63d8b@linux.ibm.com>
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-18-freude@linux.ibm.com>
 <33187980-d8d8-43f4-a138-34c67fa63d8b@linux.ibm.com>
Message-ID: <8068c6b81fca91a619c3ea9b116ad5c8@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDExNSBTYWx0ZWRfX5xVWrQrTlvmu
 Ae1xTtGayUGNwL0gohPFBI8PekPADYNpSoVqn+AUz1r4oC3pa5vzW7EB/2QIiMv0fTVyCTjiLI4
 PB+mZdp8szEOCHzaFG/lr6gWmD6HPKg1egw1vzTIf6yzylrs8HeG9spzzYS75QZo4N1WeV3Ach3
 S7+fOgj5tcK1OUHxOyshVTAn6XUSEiuIHO2TbpvXiybAvcgVaiFMBVyVziDsUbfMSTPZWMoXbvO
 GcOzRheqKia7BXeyswmzcl656lpfM77llUKfY1PBcHZihiuk0l043gGbXFgbw6AU3m80NilSGFS
 pTtnmpll9RJ0BjcYhzo3xOkjme0bhTMnFKL3tHF2YxDYAvLUbSVXFgHnLAl2CW9fPUUc/gf1qWe
 iMrs7hXCDc3avnhxrqeMbBCafgODCHXJ4Wy34gO8Meofvi0XMbwaRF55ZQxcyKzTQWynjR6HJB8
 jz3O0nLP2UT/H9PBGjw==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a6203cd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=woZNQi_L4tNMqXH-QfIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: o9g1NUi2OHWi-bi9tGembB_6OOe8PmfS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDExNSBTYWx0ZWRfX89Q66KUs8kbL
 v3u58yJhE6AR55hpx+PyeXJAX+PX3cYWUMhgxvSdFajQ623V6qqPULO+4eigrhr9GJgkVT/4Utp
 juiWhaSHtBP868IwJnYqwK6SZhDYVoA=
X-Proofpoint-GUID: o9g1NUi2OHWi-bi9tGembB_6OOe8PmfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230115

On 2026-07-14 14:01, Ilya Leoshkevich wrote:
> On 7/10/26 17:29, Harald Freudenberger wrote:
>> Add simple tests for the CPACF instructions implemented:
>> - kdsa - minimal as only query is implemented
>> - kimd - query, sha256, sha512
>> - klmd - query, sha256, sha512
>> - km - query, aes 128, 192, 256 with clear and prot key
>> - kmac - minimal as only query is implemented
>> - kmc - query, aes 128, 192, 256 with clear and prot key
>> - kmctr - query, aes 128, 192, 256 with clear and prot key
>> - pcc - query, xts aes 128, 256 and prot key xts aes 128, 256
>> - prno - query, trng
>> No test for pckmo as this is a privileged instruction.
>> No test for kma, kmf, kmo as these instructions are currently
>> not implemented at all.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/tcg/cpacf.h        |   7 +
>>   tests/tcg/s390x/Makefile.target |   9 +
>>   tests/tcg/s390x/cpacf-kdsa.c    |  58 ++++
>>   tests/tcg/s390x/cpacf-kimd.c    | 166 +++++++++
>>   tests/tcg/s390x/cpacf-klmd.c    | 206 +++++++++++
>>   tests/tcg/s390x/cpacf-km.c      | 590 
>> ++++++++++++++++++++++++++++++++
>>   tests/tcg/s390x/cpacf-kmac.c    |  58 ++++
>>   tests/tcg/s390x/cpacf-kmc.c     | 351 +++++++++++++++++++
>>   tests/tcg/s390x/cpacf-kmctr.c   | 360 +++++++++++++++++++
>>   tests/tcg/s390x/cpacf-pcc.c     | 245 +++++++++++++
>>   tests/tcg/s390x/cpacf-prno.c    | 131 +++++++
>>   tests/tcg/s390x/cpacf.h         | 571 
>> +++++++++++++++++++++++++++++++
>>   12 files changed, 2752 insertions(+)
>>   create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
>>   create mode 100644 tests/tcg/s390x/cpacf-kimd.c
>>   create mode 100644 tests/tcg/s390x/cpacf-klmd.c
>>   create mode 100644 tests/tcg/s390x/cpacf-km.c
>>   create mode 100644 tests/tcg/s390x/cpacf-kmac.c
>>   create mode 100644 tests/tcg/s390x/cpacf-kmc.c
>>   create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
>>   create mode 100644 tests/tcg/s390x/cpacf-pcc.c
>>   create mode 100644 tests/tcg/s390x/cpacf-prno.c
>>   create mode 100644 tests/tcg/s390x/cpacf.h
> 
> I get failures when running these on a real z17, for example:
> 
> $ ./cpacf-kdsa
> test_kdsa_query failed
> cpacf-kdsa: 1 failures

Ok, I only tested on qemu. But of course you are right, it should
work fine on a real machine also. Will check this ...

Oh maybe one thing: query works with a fixed bitfield of subfunctions
which are supported - by the QEMU CPACF implementation. So a real
query may result in a lot of more subfunctions enabled in the result
bitfield and thus the compare will fail.
