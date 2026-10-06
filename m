Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DE49F100;
	Tue,  6 Oct 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303531; cv=none; b=W1bbjkirhaDG9tBU1/uuu2Oq8AxTXqGOwLnCPDC36+BtGG0Qpw45gvtx3gPLU6b6axV8W2oRVtnJ0Ympilsbu9UimZi/VwVeRsmjb/nWOLgAG4R+xSZzp2MF9/NJfuQoVq2LSwBFJN4akGtSspWAuXaUn7rxc3UAursQinL1ceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303531; c=relaxed/simple;
	bh=tWLjRn+WCa3hiItjul4dgLRJFQiFSjaiNkF3CxJ1nBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWqZNmzF4bUnfX+aJDQIoCBbcIb2L3Enn/2UX+Cmr583ZFy+D52W1XaKpvsDmdiVj/l97EGkdjQSOH4Rt1/OxAMgroPDgQVuktXFK/o5Md+gdVSYqfyVTpO15qjLMPxAx4/Ty8xbtgp85UHAghVE2CYEDiheHZpqF3HzXmzztVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=itoo5HJ9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="itoo5HJ9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZdFQ3852055;
	Tue, 6 Oct 2026 16:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=u8WNbSQ2NndjPV7iXRF4G6F
	v0k/2ZGfjflcFjlvJ7aM=; b=itoo5HJ9p8Ott3EQNGX9ERsAWGMp3M35FoMCRzI
	1/Tb6Ax8RzF9LxUhJtON1EDYlBj6kN5Kx/3ZJAar3StzBNafbraD8P9Bw9SB8c4N
	rVrd46s9I+0AwEVcVwFAdbF+XoXhdk1vyFXpRHx5a7QLP2e8XWzemy7tdfBvAjVX
	32SL/4bKI6MGZNjf1ZnxSXI+GEXnPAMd4UdBX1hpeEWPYRlut5QNW4+BZAsdFutU
	n5/orjHiA6jx4d7GWzjTojXBBf3fBvXha6YnVZTgzUG3Hc3OElmVi6+blJolkFJN
	NZfRjJrhjN+hdXRIj97au0KL5+CQABsKL2y7wQ60VsN6qGg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jrey6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 16:18:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHVVZ453041;
	Tue, 6 Oct 2026 16:18:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgtkb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 16:18:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696GI75K28967516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 16:18:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42FF72004B;
	Tue,  6 Oct 2026 16:18:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 232F120040;
	Tue,  6 Oct 2026 16:18:07 +0000 (GMT)
Received: from vela (unknown [9.111.1.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 16:18:07 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.5)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1xE7ri-00000000wFB-25qK;
	Tue, 06 Oct 2026 18:18:06 +0200
Date: Tue, 6 Oct 2026 18:18:06 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v9 03/24] KVM: Replace CONFIG_KVM_MMIO with KVM_NO_MMIO
Message-ID: <asUfPttGx9Mh9Q6D@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-4-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930173441.66762-4-seiden@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ZQaIic_21IstwC9g1Aae6xM8uNoUTjIk
X-Proofpoint-GUID: -diri8LhwNDbu0AyvUTAhE-ZvbnfI-Pu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2NCBTYWx0ZWRfX48QBrn+w0nnv
 ewO99Xt9kMPRL6JGRFNvKgKuM8XnKsdfcpp863vOIJe9EpvR7itwurzjVLBgO2jD/zfz3MkVGYP
 RmKn+ZsooGv8oIrvD52NPtt4VYRMdH0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2NCBTYWx0ZWRfX2/1OhitB30O8
 iXws3zZPHfh9D9yMRMC4haXynDtKHZp0nSHk8zuT6WQCpJKVY3GHmrkGzpB8YSrFxyTZ97ujvEZ
 TERBYrKUHWb1isxboA09YDBuhHzjGQkvB4tooWXRxULAHH252JEwQS3x1OPtrfT45PUUFzxh6le
 FZoSg0FYos2pzINhuWhbHBmMbBx35oG6U728PXQRNIvXw0m3b2qK+uxahVby7OlIokVvgyy7pTW
 npWMiyZVbHWFa33d8CBQwJTCBqOEgPt2UdRAMoTiY3wesEJ8y1k/knsBDLNCcRvLegCeh9SiihW
 kYo6eYV28cIykgYpCU0grkPsxlJ7tbsYjVKRwKrWpKjFBU5e3PDa7gU19raGnYjh+Ar39pL2Hyd
 EM6jE7JTNrxbzSSjHdRiuzlWxwv1B0T56WTZ6x0cSb4vkvCdjdpb0A66DFgftEpGGzR9dPlIG0n
 CXxl03Bpzmlnv69Kvlw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac51f46 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=o_ygevbwOlYE398wOkEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060064

On Wed, Sep 30, 2026 at 07:34:18PM +0200, Steffen Eiden wrote:
> Defining KVM_MMIO is not flexible enough for multi-KVM systems where one
> KVM implements MMIO but others do not. Therefore, remove KVM_MMIO from
> the config space and use the macro KVM_NO_MMIO instead.
> Define KVM_NO_MMIO for KVM/s390 and for selected KVM/powerpc
> configurations.
> 
> coalesced_mmio.c is now always compiled&linked. However, for
> architectures/configurations defining KVM_NO_MMIO this effectively
> collapses to an empty object with no mmio code.
> 
> No functional changes.

Changes look good to me.

> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Thanks!

Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
