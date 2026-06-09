Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074E425CCE;
	Tue,  9 Jun 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013131; cv=none; b=ipKycOrDN0UTFxKvD61IQ8JDzPhIN1EiAMCDG37YneNhIlmNPJDtpk6hYI4onH0lTBYwFaA5drsjdIMPZvVWAijU6h/9ymGMsAbqnl4LH0TwMld7v4uhqZkMP1oVrKt9DkxBB/Snf/13YlqQjIYVCY2+34xk7AMlxP1tDkuyhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013131; c=relaxed/simple;
	bh=8RXyomckAuriW7xZC+DoJsoZGK2RK+2DMlXe4GX1CE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAHWbKCKcnP/gIad2pBh2U2V6e7aLyhFINxdpQYEoiEeyy+3FHS6Nt5x4pE41QWW65xG15Hcb0BPz/KNYGjwlSz5fhMT1MI1ktK7C6CgkZIDQs8iN87Ok1IvSNCIHNQ0D7ifDYGnkAwPsG4zTK8UpaDeaOqpjlBstTBGkntakiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ftws1/Aq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ftws1/Aq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659DBWgr2465898;
	Tue, 9 Jun 2026 13:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8RXyomckAuriW7xZC+DoJsoZGK2RK+
	2DMlXe4GX1CE0=; b=ftws1/AqS+yy+3XBC3HrSorlLkL2osMdXSmpcycTD6JhoO
	FNRB+sBx1pkssKtJletIrOYDMLiyHkNZVhqtht+0tf+01HSOoTPr4BKczEPz17y/
	DydNeYlz1CHiDjYnJ7uEahCWinmOAfjdrt6GP2t9EuS6AJjlNHiSRUQSvG3ybTF0
	jc1WtUWuS1S3ta7g+UCs/MHq4McqmUqYSNjVNh0qsv4jcF61yHMl7l2SDWOFxWJm
	Q/Lbn576alHPyCL6ioAHXYt8mNvdoNnxBRAI/NcVCbPsWMCg3FKgNIODNAjWR45J
	no+L4+IbKPtCU/GK4FFGmPa5ajY/2iZymU9wYWaA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sv596-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:51:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659Dnegf031082;
	Tue, 9 Jun 2026 13:51:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy9ytx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:51:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659Dpnnp18219294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:51:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F395F2004D;
	Tue,  9 Jun 2026 13:51:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA2C720040;
	Tue,  9 Jun 2026 13:51:47 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.132.52])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 13:51:47 +0000 (GMT)
Date: Tue, 9 Jun 2026 15:51:46 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Jan Polensky <japo@linux.ibm.com>, Gary Guo <gary@garyguo.net>
Cc: Gary Guo <gary@garyguo.net>, hca@linux.ibm.com, gor@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, boqun@kernel.org, bjorn3_gh@protonmail.com,
        lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
        dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org,
        linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
Message-ID: <6f4baa3d-07fe-417a-a46c-c7328e026bf1-agordeev@linux.ibm.com>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
 <20260608181451.3734956-7-japo@linux.ibm.com>
 <DJ3VN4EYXCUA.18YA9379UHT5Z@garyguo.net>
 <aicb5a1_SG5B_ByM@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aicb5a1_SG5B_ByM@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: U1Gtzt8uVWtcDC-0bUHIW8TxWx2BTvh5
X-Proofpoint-GUID: XccGxzHHcQYfJxzdZPdI5l8-UTflw9jC
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a281a79 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=0GDPdn7TV4dO_mzl1qoA:9
 a=CjuIK1q_8ugA:10 a=7jBqKnKQzRwA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyOSBTYWx0ZWRfX1JggMM1CR+Sg
 F+pBtKLSYN6Oco2fEKTVaUXWNdhnTq+0SmBoQ5gR0HdRDaSiZTk8QnQ7e3Sa5gxgNumzLfUZXxP
 80M7YzJMtV8DY3rJl5C7JhP4yL37ClKmuWbkoTUm0dGdFbv8eyZIiuh4gLktfMqhvqjiKvtIqDt
 RfKXFHCZfvf0DAtRG74AztQWM2Ah6D5uhAYc2nUo7hR7Qr+QiC8hJ1w4bhmFrqVsCxs+fVZ0pu/
 aC4wuYP1ow4/doqD5aWxR1rszvu+HNNiWOFw4WI0gwirHYcuRlUB8e7HaCPLzMuO2+8Lki+7kPc
 Q7Tm/gv1CPCWlEXfIuDRystp+CVQEp3VcFgaROpqZSfTgPkhCSIpA0yoxmvYn6sKnxp/DbHM/KH
 drGAKreauPj/6NzAyqWbtHYP4yY5+tPhTqilRnwJxB9lJvWN/x9Rj2Ka0HyRb4kP8GAGgWs+dI8
 3Q37HW0rt0Aj0Erd5kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090129

On Mon, Jun 08, 2026 at 09:45:41PM +0200, Jan Polensky wrote:

Hi Gary!

...

> Backend support is planned, but has not been implemented yet. Until then,
> keeping Rust support gated behind !CONFIG_EXPOLINE is the intentional and
> conservative choice for this series.

Is there anything in this series of concern to you?

Thanks!

> Best,
> Jan
