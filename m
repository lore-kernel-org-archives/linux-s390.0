Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C73890ED;
	Mon, 23 Mar 2026 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261601; cv=none; b=EX7EpHD6lKbCSIJQkIfXSd2WxjKv4oAo+KvMObvrIPh9vgChg/LYYUs/wUhFL6enh/9YGgwOAZyK/sSFOOTF96Ce9LBS7t3FlT2Aq3q4V7mbWLvMij2UJKmB3n8lFi0ZL2e00+f7rogjv8zILAcDwbwihBd+Fufe9zCQ2j2ADag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261601; c=relaxed/simple;
	bh=a8xmEpi21YZue0so74Ntz3Ki6UvzMWa+vK/eG8jljjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovNMxjRhVrWp6Mkk8xx6YU2VEMBfs3Nh1dcQoptzIM1J5fE0jXmnAteuwd7M3Yv9KJFCKI5ZJs/df6sPzmqvhx62oreJUvzmA/FlydPOG6v9k4L9po0Lzv2FIvh1jOW8NnoFttnQ8MiyOuM9zwjiKLbxAEPFkJozuAAaQq/O1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ApcDPClk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ApcDPClk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MLkW5c768705;
	Mon, 23 Mar 2026 10:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dHnVeZeh27XciBiJv3mxxU+APbyHdp
	LcpZp5RqwoX2s=; b=ApcDPClkJgH0SMKJPO7Um2p3g8X+l+36RtjEHRa6Lu6lFV
	PDxaf6j4Nb+XW1V1dmHdGwMFMRGvtbHzE/Yp8vD729/Wp+2KBn8bYmIBlVyzcF29
	9/YtaDjrdM7rpkoXlQ5oQNU6jiLtBvCY0bIqFHwLd+7jZpzRayLHY+xwXTEesXiy
	+mPFfpjt6SPAIKznujOz4cCHgcBStiMgRxgi9Mwafk+0fuHIiGAIsDUOi/uuzpE/
	0BlhjN6vI51PZOSOF4Ya8ZflI6LRrjEZ34NPdivV1Wv/U3FUhVR5JJJb7MWbGZnV
	qAysQiI6jfvS18w7pyxq0qJa9AJlCBJ8gT1nBX6A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq6ca8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:26:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N919sp004399;
	Mon, 23 Mar 2026 10:26:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1vpe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:26:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NAQSVP54395298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:26:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8DE20049;
	Mon, 23 Mar 2026 10:26:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E582004B;
	Mon, 23 Mar 2026 10:26:27 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.141.143])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 10:26:27 +0000 (GMT)
Date: Mon, 23 Mar 2026 11:26:26 +0100
From: Juergen Christ <jchrist@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/9] s390: Improve this_cpu operations
Message-ID: <dd60c8c7-5b02-49c3-9336-6b2213460d50-jchrist@linux.ibm.com>
References: <20260317195436.2276810-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317195436.2276810-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: of0IcR1g2hIuCdxegE5n9kPmCZXOki1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MCBTYWx0ZWRfX4y/SGUQWSpdg
 Yur4IzheQf0au4qu1EGNmcdxn9NTBOif2RGAQJ+RKZcHnkT9mLaVfPBOX274qLz6n3bQaUrefyc
 oWpAWVUTJNFHQRxlNHORw8pt5Ib/Q0eRgXjTtBJrJTCWmlHufrJG7gWWLGjiipzrbljPU0Urgf7
 USxYBoszAczz/TJWbMEQAAzUIx1Gq/fajCZGDLaoc4BU+m8ioFmoHzDwdnFNjndWRD7kBBA1JTw
 ScaxyzaqHRNs5mDutkKv0lNVVlLG79HBYnGefqyYZ6ysCzJ6QQVJgP8BFCOi1KSTirNIZAftBcA
 bH64NjWRCHvmbzAEoMVJWY6vIW1AVRa8WXjAsIv4Wj+1jsZRBjmQghX/9WR5xmT41TpdSZkWvCv
 gI2wMvTYCQu1lfX3lLjXNJh01i3AvQzkk0Hx8u4x/UplVRzQMwDYOFxvNs3Zb9vfT8dvI9MUFWW
 U3beh35SHRKyUBKg3lg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c11559 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=dLLZtUcoKrmZuQtdb14A:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: of0IcR1g2hIuCdxegE5n9kPmCZXOki1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230080

> This is a follow-up to Peter Zijlstra's in-kernel rseq RFC [1].
> 
> With the intended removal of PREEMPT_NONE this_cpu operations based on
> atomic instructions, guarded with preempt_disable()/preempt_enable() pairs,
> become more expensive: the preempt_disable() / preempt_enable() pairs are
> not optimized away anymore during compile time.
> 
> In particular the conditional call to preempt_schedule_notrace() after
> preempt_enable() adds additional code and register pressure.
> 
> To avoid this Peter suggested an in-kernel rseq approach. While this would
> certainly work, this series tries to come up with a solution which uses
> less instructions and doesn't require to repeat instruction sequences.
> 
> The idea is that this_cpu operations based on atomic instructions are
> guarded with mvyi instructions:

Here and in other places in the commit messages and comments you refer
to a "mvyi" instruction.  This should always be "mviy".
