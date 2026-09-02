Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389631A07F;
	Wed,  2 Sep 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339466; cv=none; b=SXwM0dfPP1qxPVj710xKZpcxKthZk1kBou91I2/wvIh97NRvlhEsDHuekAvMBw9fB1JDUXU9zujvM1g/3ZtuvS6OUyUheM9kVgJo2JYojmYc9mv+oIFv2obyar2oPrZ+a2SobShnp4feW3SNjyKVUPVHqeVZhBDh9xHcTFoduW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339466; c=relaxed/simple;
	bh=mfubn4HGkaDXxsPE4GgSg2OWGqdQXm1srLxvNrb+mXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjYweQjoJLWEozKdmO5lf7wfEFDbn2jWN8eIVPS10Mcl/0P5/UywUw3LFOlFCWgWNYQg/okQ/hd1+1mGrSVT6w+snUXnRX8CrYOCrhp1nCuLA7qaXE8L95ALLdzPqIou/Prnz0Mwr8VlTrsLME2sKdTmIod9Ki6bN6jrexoUuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bdA14QVE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bdA14QVE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826Wmrc3320543;
	Wed, 2 Sep 2026 08:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eIVDYs
	PrzaUBl/vQBhBImig9R8w/tqVsN1lLv5gBATo=; b=bdA14QVE3X6X1RvEgP8K49
	D0j5dxoNeG8YMXkexOPI3dZlfBhNjp6X50FJEFueHkyqSzDRK/pYsB7L1hB9QgqG
	zOpZvsvuetAv6A9B5g4EYF8ZuoehxSuctv4fM7iuYkA5laNTQ+GmgLdM+5N7TtY1
	e4IhoMmvGU3QfeED0odg0jt1ZnJEnIBS4VwPzqdBiZSg6qzOjfWN7Z77sWny/bJx
	Y7SlknFdjZNRBJUN9raj7Uv0m5cKhBIsqKcakxCcaDwMZNeAnJXND/N+PXSItjTk
	njLYqpiVmTn6AzaAke33IE+hunlkAtj5wr/guYwxB8rOhv9n6k7wspkxDSU+G1Cw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhw8k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 08:57:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6828uJkQ013346;
	Wed, 2 Sep 2026 08:57:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjah33k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 08:57:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6828vdUf50004416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 08:57:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA45B20043;
	Wed,  2 Sep 2026 08:57:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D13AF20040;
	Wed,  2 Sep 2026 08:57:37 +0000 (GMT)
Received: from [9.123.2.132] (unknown [9.123.2.132])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 08:57:37 +0000 (GMT)
Message-ID: <3a4bd99a-ce48-4c7e-93b9-ac00d14e1a29@linux.ibm.com>
Date: Wed, 2 Sep 2026 14:27:36 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] s390/ctcm: Convert fsm.h to proper kernel-doc
 format
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260803182736.2356374-1-nagamani@linux.ibm.com>
 <20260804182758.C19221F000E9@smtp.kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <20260804182758.C19221F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L5PqjzlA_rJBeU2HFzUOg9FgIpHSoNcO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3NSBTYWx0ZWRfX2S7A4ft4lcLr
 7vgJYvkSRbBrON6yF1Nfw9t5GjS/rlobJO6f9bZ4qcLvXueI45zRY8wn2cZQUciukJXeON5Q7ma
 FWxf3VHe8R1dxFWl5dVtiXGCSfWFQFx5VTV+roPj0PwtZHcbHicaGMLZSFSR3gtOIuF9ZLudBEi
 FJjS1Jmv3BziIUqrjCy4S3zWy9HPC87fL//U/sf7odGPtolPdFJdRMA7quCqrTGQlsMMArSERKk
 94XqcqmxdslO1dqUGfOPI2dKdhhjwKt81132eadGqTWZvSLOCc/2jqpp80XBjaUAXR6nlXeZXOq
 Aw3cHFHEgNTbi9Mdmnh8QTvAKRoPojfO9SkxHlJxMNIFd5kWPmGNM8vmyuyY9rr6pUn/6S3GZMF
 8izEnReS10mFPWERkc7FbhPiqQn3uKgI9C9iQlxwn+VNV/6Ein+nvZWvWT+yteZDIB3M946ndjE
 0DJV8ubfhb4TPn0+FlQ==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a97e507 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=k7y3X17h0ifYduAclZMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3NSBTYWx0ZWRfX4NCWmiyrezti
 ltCbTc8Z5ICkXnYxcHQjaFDjEove51qwM689iDmyFkOHQUDNGiBeyOzeCHZBZd7WNH+3TMkT2X5
 TmpvGT3fuLlO01b5T4CJT6K5ql4xOr4=
X-Proofpoint-ORIG-GUID: L5PqjzlA_rJBeU2HFzUOg9FgIpHSoNcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020075



On 04/08/26 11:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `fsm_deltimer()` uses non-sync `timer_delete()`, which can lead to a use-after-free when timers are freed during teardown.
> - [High] `fsm_addtimer()` unconditionally calls `timer_setup()`, which corrupts the timer wheel if the timer is already active.
Both findings confirmed, reviewed and validated. Note: the report
references ctcm_free_channel() which does not exist; the actual
teardown function is channel_remove() in ctcm_main.c.

Fixes will be submitted to netdev@vger.kernel.org shortly as a
two-patch series.

Nagamani
