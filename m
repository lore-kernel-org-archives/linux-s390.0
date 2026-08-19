Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3B42F704;
	Wed, 19 Aug 2026 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130919; cv=none; b=NVWgEfw7wfV9i0Fe2axfWHVTwOFOLErPg+s0+vuLb+6Z1ga9pWDZFSS+p14l6o+3gXaUu4hT07UUWilFExjdP0XZEdAgy2RAJSw7ODz2C6zzPHcohEtWabBYDuwv6zIm4s8IVsenkteSAx9cdu58KQa/0zHarhoz1JMnbZhkxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130919; c=relaxed/simple;
	bh=dFDJEPNPLMmkLrEwejO7JMa+mG91YcxBSLi9fOH6VGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CL96X8Qnj/aRvzS9nMHedmQCTjqdnQwJdJH4lzdCi1meDMQTub5c7M9Ms8jH6CN8jbwlOdhNLAaeiafVKzbRh7fGicwG1BW3DkmMvIOlkrvzQDNt+RjCkedv8rBB6CyW2BU2kvaxpPTPGNNXAw19vx4pczup18Qema54uiLDlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G1Me53+m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G1Me53+m"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6Vkun797607;
	Wed, 19 Aug 2026 09:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=acuVZX
	kyEx/fnXMuZiHmZ4fxwClh6TJ3nC60rWRoyQI=; b=G1Me53+m7kBhoBzj8FbioQ
	S4zLZuQ4eGlCBsk8WbIeJUHhVT2caD0fO37MBiMF0RniVjE7pg5qK1IK9UxtW6x2
	O4LSYeZAdMf0tiTogCJH/UYf21tSpDZpk+mO1nH8jcuTO/Ty0uv67TiGbzGMJoyp
	wLaTzoDBEvh5f1Ry07oQENUCzcp8S+pN3RvR/6DgRKb7PUQmEq6DHfLiY+MC1kgS
	wRKTHvWh7lO462CbSkE4olWnTfJuGPq7+PwUHYE9W3HCKHAuyftck2QFMP3MuzyG
	nWZKfsAtsqx5clxz03T0U4qtK+hUn0OSQGN4kdARhE03mCVvuL8o5OEv3u+vQ4KA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu02qt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 09:15:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9BSKg032723;
	Wed, 19 Aug 2026 09:15:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngfwjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 09:15:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9F3d742009080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:15:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A1D820043;
	Wed, 19 Aug 2026 09:15:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF7D2004B;
	Wed, 19 Aug 2026 09:15:03 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:15:03 +0000 (GMT)
Message-ID: <3dadc544-5836-4472-9365-90d91a0c2618@linux.ibm.com>
Date: Wed, 19 Aug 2026 11:15:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/pai: Handle multiple PMU stop callback
 invocations
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
References: <20260819055855.1001578-1-tmricht@linux.ibm.com>
 <20260819061147.9E2851F00ACA@smtp.kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260819061147.9E2851F00ACA@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JrTHG1paNPar3rm3whWVUcRMM4HLJIcq
X-Proofpoint-GUID: JrTHG1paNPar3rm3whWVUcRMM4HLJIcq
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a85741c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=vNTNgnaILCbdAc7DXJgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfXz1eb4S+lzw5m
 3/WZkgNNMqL3Qjhz0gObptNsChI4evm78he6a5sa7mWis5+LMqVSmlCq8jRMQAMuhATuDgbi4Qd
 KPun7YnCKUSG9ehRHFBDjgRCCq72KLk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX/Vq2r2TE7pme
 kDsLycO3JDLTpvGta2LAfh1Cav3g7aZ87Ebqw94RPeGrsSdEeCUhMD9KX5yGaI0zbXs38J+TxM2
 2rdX5BZuyEjXgNmz9BehWZysetI1oIOKjV/LkmtVpFgx44QcqyPy8unYKSFIBdzlh/70IREogDy
 EtnJp0nOMjeTlOyYH8Ge553ve5rXbl17KCDWanLlYcUnA7Jlo7SLiJhhALG7M8tNoe1NVnpXPoR
 ykQMHdtLZDz6jutxaE5htJF8BKMaCn4uiQZLZBgXjBlrGDu9kdzEYfsqQcxp/0cru6dpTzg9PGN
 CTZb3V/1h5SzgF0Ur2+c7Cv42LfG2e7LQQZ8W3uNxiaXpQrjT1dOytBXidFnzQFOPqmz9YzEnhk
 JBay0C/qKgDY72jVE6gXb3CvBpuxMBE5tyatRQx6F3SzHZ98UnAQBWCXiTL2rGkPpkuvhvIirW9
 C2oMV2anilcjZL8ZtQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190068

On 8/19/26 08:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] `list_for_each_entry_safe` in `pai_have_samples()` is insufficient to prevent list corruption (dereferencing `LIST_POISON1`) when group throttling removes sibling events concurrently.

perf_event_throttle_group() walks a different list anchored
by perf_event::sibling_list. The list anchored by cpuhw::syswide
is a complete different list using different nodes.
Since events CRYPTO_ALL and NNPA_ALL are single sampling events
and the only sampling event for each PAI PMU, it makes no sense
to group the same event. Events of different PMUS can not be grouped
anyway.

> - [Medium] The patch fails to prohibit setting `event_limit`, leaving the unsupported `pai_stop()` invocation pathway open via `PERF_EVENT_IOC_REFRESH`.
> --
> 
This needs to be addressed in a follow-on patch, the invocation of perf_event_refresh() can not
be blocked right now. Maybe add a new PMU call back.


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
