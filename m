Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11D364927
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772950; cv=none; b=JFdkTSahTEELI8Nqx5917FI4bB0Ah/0bBhITAdDcEYWeKUSix0WIQpXcymq2gZ2eJhN8xZvuKIdCchFtRq2DHhrlBzmaKLtBw6n+8gUORtGhw3NFBZsZp9CE4Er9C/rblsUEOiIEUlpDrFSPpPDwQKyy0auuDKCPHHhDakdVTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772950; c=relaxed/simple;
	bh=pmjc9+AEVpe1IS5Q22oBJb+1U0AcKax6SnYTBcQ+b24=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nW1wlHHGGs043fDEcVmF1aUSqmHurX0xHdWSSFHdNWiuK+vc0Z2CRjh6Pa+m60XjmlB66f5y23rNvQTZoAKDkVTA7fSwCkW2FET+gug9h9ggCwbcKOkSNOIIzBD/vHufpU+O7MwVIBwbT6ePF+hUGZZxzCYs0ihsipf+GESX2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PpR000OX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PpR000OX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHidi2201838;
	Mon, 3 Aug 2026 16:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=Iyj9crm+VRLjWm5bjVht9K0DwiaObMDuJ27TTpmbIKE=; b=PpR000OXDWho
	f8uq8i1vCtZCIbTnRXOKQB67y1nnAnaemd7mNN/xe2urYwMzMPKGgLk9stzOV58R
	aJzTssGF44eBsL5//f+7AJEOpAaepUHBFmNMFbkdyFEm0rrzFwVqwS/yF7/y982D
	9CefP1FTPeCwbRUOlAO1eDsPBW1PqZJXoq5fqqt7l1pDXJUzIRPJ4RrNhQR2u4Hj
	Hvi2aXs+ZwRhGwytW4jg6GqRnAx3LcaAJH9dxTaI5WKWY2p8tBNwlmiCdz1Kxsk6
	L2GhDzInZjeuhCRFlE5DsAkO47Do4LHDeok1+VLVEnbONtoD8l6tLQ3CsRkrKnsv
	dr/1pid1cg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhmhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:02:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuJGt022293;
	Mon, 3 Aug 2026 16:02:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5wy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:02:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G2GIj14025444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:02:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 138D958063;
	Mon,  3 Aug 2026 16:02:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05F2158052;
	Mon,  3 Aug 2026 16:02:15 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:02:14 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Aug 2026 18:02:14 +0200
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
Message-ID: <72aea3ecd43734528217857025ed8540@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX1vWLjRirQPdb
 +Kb2PCikWC8IX8LEkwJHR8ae9KkS3Yjipbb16exog+vyEVRhdDAmBmutBUP/JqrS5qdIVLsi3Qt
 tvRh7PEwZAxPCuZDS632h2rSH6YaYcM=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70bb8a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=woZNQi_L4tNMqXH-QfIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX/AOgi5Dt1bLK
 uyU5e33y75lQHGKh9tQYxLQDZVKQzo83yxDekDCQDCGtk55EE4CSurVx/A36X+i4BruJqnbJO6E
 DjtxrWBA65Wye5ThAV38oKOqfH9vS4Vv+tAVoCqXvqZolRtgZEM6VFEra3NRk6d1KSjtPy9TyYu
 CP8z2ItTRvOlNlyraS56XBJvvaLD7cJiV8fCa2Gpuwlfr8z4XaWNbtspdAL3L6D33ZZHEghh+zK
 EzPUKK/qUwuFAZ1NinABISa7k+5nDP3e+LsPMKrMe7fQqLR/UG/MIVa1kTFnbweBCSb4uowYr1g
 ihMpQyzhd40O9h8v//DuB1FbbE2NQP/GxOakhKsOpZDMNNSoU8Kp65nxJDQuj33UD1Zuiag5Hse
 yASTziMUmy1G3j7ujlCKoE9ATlinVxr6NSllRO/90Ps3tfTqzJaydOIBARHlSdNV1+egTsbpwZR
 9GOD93jAsIafKlERwLw==
X-Proofpoint-ORIG-GUID: biStc7ri1XmccvK00SEhB5y-NX8aWkIf
X-Proofpoint-GUID: biStc7ri1XmccvK00SEhB5y-NX8aWkIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

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

I've reworked the testcases - see v13 coming soon.
The query function now compares against the minimal expected
subfunction set but does not fail if there are more subfunctions
available. However, the tests will still fail when run on real
hardware when it comes to protected key related operations.
