Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704476;
	b=fn3QgE47CWXVsYETPw0brTaUfBZh1VOCAv7fymOFPbbYQ3Z3KmzyZMg4NNfBegwNkyQV
	 PLIUHHamGKumOuHHoKd9y4rykfVLOsDFs3u8AJtqyk6AXr4LgZ49Nq+2BVLAqhyDszdcq
	 nVmYj0T7Am4IxeZdlLcmETWsWsOupbG1X63dxBhiOG+vD4D+edtumhD2n+pZIlncneNQ5
	 y/8npVGJERi+2nIiv5it68pt57/yslmFExJnmVyF16+TFbetY4/2xm6FMnys7coKqFfBX
	 gQeLL4ke7XnfyaVpUpRXpLT4aBxZZ1rTQXL/VLDxqnyO/PGwrNeeMB4g1lADdUNjBCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704476;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QhBaUKeAymIbh5HaMvFhZG67tK08ckFM1cZ8rclk9xs=;
	b=q1yBRx5bmWpRp+Vz+eQWEp6ShwIZVOpfAbcCPRWvruGYigxmWiMbmXEqn/4ozD1q2lIj
	 5Nd/KwtH85xGllnmD0VOC3ge7WWIsLwVZhsJDbrwXtpNIIrPsWE1yv8bmlNBVuVf94ld4
	 iqCIOazh461SmWH0oQEKhRpZXNF0TVR8sh9ywIqgLMGzsMU/GKw+MQGXzU/fFfgooIgCN
	 VU9h29pPy13YBYFbzbmELE+OklsDiKdprw/ogjn7JMH9rUTlfrEB3MIJDvLRpiqAx8D1f
	 4J1UVLCsr7AHWeaS8WyqHT2uTT2NJasleHTmLexhZUKyXOquWtCYOHsF6H3AkrALNgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KjtLw4e2;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61F606A337
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 14:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF61F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KjtLw4e2
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQEYnTd387737
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 14:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QhBaUK
	eAymIbh5HaMvFhZG67tK08ckFM1cZ8rclk9xs=; b=KjtLw4e2IcmqvRYIpt+Rs9
	s7cm8ymKJFNxvWpRjrGHPvdQPpaOd6PliLeKUOIZnnl5dgdc985v4miT+pGynL41
	ZUPs4jW/9vxas796gQo77Fu0NQo4UDOt4Uc/p9yIN/qbgA6AanIfSDUhm/VT11F0
	ZFqVJZb3culpW6/6dnX20995ltM8F5fRVrc0oLoFF1GFAM/vbKAHj7QqxfNrhqlF
	7g4Ke3JsUPfGwbuEKa/iJ7x3Yb7o/Jzes/2JTGso9yncX0dxwKOtHzhrISPPixxR
	PaoukUfL/UggmoY35JLTik0p2rNtQFfH3x17A6wKQBxsqHdWAtRt4lMozmVGn3vw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvh6s2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 14:47:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQEYQ3d1733406
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 14:47:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx552r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 14:47:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQElqnT30802666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 14:47:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F0058043;
	Thu, 26 Nov 2026 14:47:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BBAB58053;
	Thu, 26 Nov 2026 14:47:51 +0000 (GMT)
Received: from [9.68.22.221] (unknown [9.68.22.221])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 14:47:51 +0000 (GMT)
Message-ID: <a28f9b21-22e5-4ef4-9958-c12d8f24935c@linux.ibm.com>
Date: Thu, 26 Nov 2026 15:47:49 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] s390/sclp: Misc fixes
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261110113047.238367-1-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b08469a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=yWx3VUk65LT8FjZuhnUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfX+b2Nvp3MgwR6
 baccnANcXGCO0JxugDK0Y2AZ+aqnHwwLGLgAXo2lHGMnrt8DnzWjmwNV3wb+yjGtp9m/7dXtLo/
 HvLmbYoAwLqHkccCTeg23BF5Mso7Mzk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfXzRYvqqbqqFkz
 EByhtwimjD2HEwCazqVAcCyELhocBZ0PoDZ9aZ6rBPtc/hj3gYYqcTR0hR5NIobtix3FMOFaE4f
 4O7SR8+Fh5jOUgbMVDd468zvQTtis1JV0M+YgXIFrnKJNPfeauyoAELCuz7PgtL2JrL/+LrGuaR
 EDnQhrAJ3+4iJpVtsp38ZP0IrWijEa/AQKeDulSC6nsHO9odwf1GLwS74R2STL4TqMOF88xzlMv
 JALMmXqtj1vTz1w03fRPlXfXjZHxJrmm+zRLLiE1Z8PcKEkLno8gFEBKiqGQ2fqe1jDF2nAmXtw
 frxWI7nt91XL0oaPSLQ6j3FJ6l73d94sXpGbhHscwtcEdn3n0C4iYfhTcw0MUVwh57q1FNuR7q/
 NpnBncyGWb+itQ4bLFq4rM6rlk4uYyIwMHvgA7GGjYeAor6c8ReBQQmgvWmt2IxZPJJlSK9QFR8
 Or7sqv8RiZVNDObfUdA==
X-Proofpoint-ORIG-GUID: Vxad_ddTm8F-gTB598dDXbMD65aHJGmL
X-Proofpoint-GUID: Vxad_ddTm8F-gTB598dDXbMD65aHJGmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260057

On 10.11.2026 12:30, Alexander Egorenkov wrote:
> This series consists of several fixes for the s390 SCLP driver.
> 
> * The first patch makes sclp_dispatch_evbufs() more safe while parsing event buffers
>   contained in a received SCCB buffer.
> * The second patch introduces the macro sclp_gds_for_each() to safely iterate over
>   GDS {sub}vectors and serves to improve error handling in sclp_find_gds_{sub}vector()
>   to prevent out-of-range memory read and potential infinite loops
>   when a malformed event buffer is received from SCLP.
> * The third patch reuses the macro sclp_gds_for_each() in SCLP TTY introduced in the first patch
>   to replace manual and error-prone iteration over entries of a GDS {sub}vector to fix
>   the same issues addressed in the first patch.
> * The fourth patch fixes 2 potential illegal memory accesses when reading
>   the value from a GDS subvector in SCLP event buffers sent by OCF.
> * The fifth patch fixes race situations with in-flight callbacks and sclp_unregister() calls.
> 
> Changes since v7
> ----------------
> - Fixed checkpatch.pl complaints in patch #2 and #3 as pointed out by Christian
> 
> Changes since v6
> ----------------
> - Rework the patch "s390/sclp: Make parsing of received event buffers more robust"
>   - Move event buffer header checks into the parsing loop to make code more readable as suggested by Peter
>   - Add check for SCCB buffer length as suggested by Peter
>   - Return with -EINVAL from sclp_dispatch_evbufs() if SCCB or event buffer checks fail
>   - Improved commit message
> 
> Changes since v5
> ----------------
> - Added patch "s390/sclp: Make parsing of received event buffers more robust"
>   - Reported by Sashiko
> - Rework the patch "s390/sclp: Introduce macro sclp_gds_for_each()"
>   - Explicit cast of start and end parameters to void* removing the need
>     for the caller to use extra void* variables for start and end, and also
>     protecting from mistakes when using non-void* variables when calculating n
> - Rework the patch "s390/sclp_ocf: Fix computation of length of GDS values"
>   - Improved commit description as suggested by Peter
> 
> Changes since v4
> ----------------
> - Drop patch "s390/sclp: Drop volatile type class from SCLP state variables"
>   - There are several doubts to it being correct in all situations
> - Introduce the macro sclp_gds_for_each()
>   - Reusable and safe iteration over GDS {sub}vectors
>   - Make use of sclp_gds_for_each() in SCLP TTY
> - Rework the patch "s390/sclp: Ensure no callback gets called after sclp_{un}register() returns"
>   - Remove waiting for SCLP mask and reading states to become idle from sclp_register() on sclp_init_mask() failure
>     - First, it is incorrect to sleep in sclp_register() which is called from atomic context
>       - sclp_console_init() -> sclp_rw_init() -> sclp_register()
>       - sclp_vt220_con_init() -> __sclp_vt220_init() -> sclp_register()
>     - Second, it is redundant because no race situation can occur if sclp_init_mask() fails because
>       in that case no events can be received from SCLP due to SCLP receive event mask update performed
>       in sclp_init_mask() having failed
>   - Add might_sleep() to sclp_unregister() to indicate that the function could potentially sleep
>   - Adjust coding style of function sclp_unregister()
> - Add "Fixes" tag where necessary
> 
> Changes since v3
> ----------------
> - Rework the patch "s390/sclp: Ensure no callback gets called after sclp_{un}register() returns"
>   - Shorten and reword the commit description
>   - Replace wake_up_all_locked() with wake_up_all()
>   - Replace sclp_init_state with sclp_mask_state in wait queue condition
>   - Call wake_up_all() unconditionally
>   - Add call to wake_up_call() in sclp_init_mask() after updating sclp_mask_state 
> 
> Changes since v2
> ----------------
> - Add 2 new patches:
>   - s390/sclp: Drop volatile type class from SCLP state variables
>   - s390/sclp: Improve robustness of sclp_find_gds_{sub}vector()
> - Rework the patch "s390/sclp: Ensure no callback gets called after sclp_unregister() returns"
>   to implement Peter Oberparleiter's suggestion with a global wait queue and checking
>   the state variables as its condition. It turns out the implementation with a single completion
>   per struct sclp_register is inadequate because theoretically the callback state_change_fn() and receive_fn()
>   could get invoked in parallel, however unlikely. Furthermore, the same race situation might happen
>   with sclp_register() too. 
> 
> Changes since v1
> ----------------
> - Drop redundant empty lines in sclp.c
> - Make commit message more verbose for the fix in sclp.c
> 
> Alexander Egorenkov (5):
>   s390/sclp: Make parsing of received event buffers more robust
>   s390/sclp: Introduce macro sclp_gds_for_each()
>   s390/sclp_tty: Make use of sclp_gds_for_each()
>   s390/sclp_ocf: Fix computation of length of GDS values
>   s390/sclp: Ensure no callback gets called after sclp_unregister()
>     returns
> 
>  drivers/s390/char/sclp.c     | 43 +++++++++++++++++++++++++++---------
>  drivers/s390/char/sclp.h     | 22 +++++++++++++-----
>  drivers/s390/char/sclp_ocf.c |  4 ++--
>  drivers/s390/char/sclp_tty.c | 21 ++++++++----------
>  4 files changed, 60 insertions(+), 30 deletions(-)

Series looks good to me. For patches 1-3:

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
