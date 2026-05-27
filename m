Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8626158C;
	Wed, 27 May 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889496; cv=none; b=T1J4Jd0URrBVWoyK2BntgqicWxN+3XqrKoQUfrYVBnBQ7k603/TJ9FHpli9xRS+Ma2Q81BTuq2rRGB79Q7O3FTV6L/jS07PGJMIw7NaNo5C/WJ01q6P3Wx9Z0ynnDHzRCMuQ+Z+YuNtsmGGWrOrM4CphBjxao3AjvKRvAbP4gaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889496; c=relaxed/simple;
	bh=KUfNdQOkceDdNDMG0UG1NCLwnmp9ILjympUpLk5ycFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGpZh2BYHZyvcW6x1ac8uC+4WF7jMWvirD75X71k8mVy4uT2PYZCT8qu7SevrWHbQB3az0ZhBWmhVQmRSmnYmR0rP4zbaC2i1bcP1p4dwWxYtIH8hLtuQqqk88Czt5aOipSkaZol4H4NQGgBUSO1gD9K4lX0BWLCYHQLNwUewPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aWyrNEoP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aWyrNEoP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCrG4F3810881;
	Wed, 27 May 2026 13:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rjAauv
	CsE8RPbqqytqtDgAb4iUfIUSALqGqXBVUU4f0=; b=aWyrNEoPbdUmef84KWdxs0
	FEo28kQ42iVq6gRL/hkDWV5WJ1aVCtphjNn0CQyTkNQySjTcS8zqe+8sintm49q7
	fzzHFCCBAl2mgQGiESH2TE+UnUb+0AfFNsrn+95x5JzUkx9t68kNitVJtsg3tZ2m
	xtWq8JToQPg9t3KIl9pycjv9sC3pPBSfVodBZra8VcQkp+Kh8uXFUhS4LjoSeEiZ
	jsvxeKFsuMyQP/d6/FZaTZ7y9aHz3im4oy0uFJruYLrzmTGQ1R8R49pAuFtr49Tl
	e+IKdbmWOS8Xks2B1e+2/EtUmRFz+PnrgtMc1DKbExJX1S3TbFGq1OPYfEMKH2Ww
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qc1j31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 13:44:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RDdCsD000887;
	Wed, 27 May 2026 13:44:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb37p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 13:44:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RDiUo550594254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 13:44:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09FF820043;
	Wed, 27 May 2026 13:44:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 940FA2004B;
	Wed, 27 May 2026 13:44:29 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 13:44:29 +0000 (GMT)
Date: Wed, 27 May 2026 15:44:28 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
        Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
        dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org,
        linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch
 glue
Message-ID: <20260527134428.9471C69-hca@linux.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com>
 <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
 <ahbJtRzeJUqpj3Ux@google.com>
 <CANiq72nATtptB+hOHAgqg8Zn_mzUSPRZUCXxnL2j0_yNqrMgOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nATtptB+hOHAgqg8Zn_mzUSPRZUCXxnL2j0_yNqrMgOw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzMyBTYWx0ZWRfXylGDjg00c0YN
 ZB4d6CSRojRKHAe4qUeqJzWJLzaiWixnzpKxKFaVweteCpdftO8HuUx8SoA/c6PSp0qs7DMabyr
 iwl8Ci0pnu49IeaMG1t7WDyyxcse0WtQsidync/dzqK1X469o0DtGBu3wAOJv0K/t8pnJLEEV3k
 R0Yu0fj9dwoPyQFas3gKVHZ0nAlSRzb5DZCqz1yoOiohHmn1FESsxPVWHq93HHllBDUZJIzuSEz
 8mcAOkcIS6dpKCuK8PzNqIZUtH64A726CgGJGItb78xojPjHekS9MVJkvhhKn6nPZAbCr8la21S
 A+m15GIAhLPW5hQOBgRnqTSzkx7rh1tAgB80AImw3pvLxUDdVpXbOWU+Va1GlsgP+6unjIVvqsX
 Sg7Bqd4QS2e6QhWXkhpEp9yM+suSmGSd9VBzu/Rkvnb0l+gERXM6Sb9HkkOg6yE9VMv7okRoeEU
 8CNfuVNB78cyxUnx9+g==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a16f543 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8
 a=fd4IrLrsY76uiRLARL4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Fn7Ujt3L4aHkdfhwG8Bm0N_PlSinXSNW
X-Proofpoint-GUID: bXlCgpG-FPO0Ns6AHjczGMQjX7BKMdQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270133

On Wed, May 27, 2026 at 02:10:25PM +0200, Miguel Ojeda wrote:
> On Wed, May 27, 2026 at 12:38 PM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > Based on some very quick research, it looks like enabling the backchain
> > target feature does not affect the ABI in the sense that mixing together
> > object files with and without this option will still work. If that's the
> > case, we can add this to the list of known target features for this
> > target in rustc, which will silence this warning.
> >
> > (If it affects the ABI in a breaking manner, it needs to be added as a
> > separate flag rather than being added as part of the -Ctarget-feature
> > flag.)
> 
> Yes, from the different discussions what I saw is that the issue was
> mixing it with `-Zpacked-struct`, but that is already rejected by the
> compiler. They also discussed whether it should have been its own
> flag, though.

I guess you meant `-Zpacked-stack`? We need both `-Zpacked-stack`, as
well as `-Ctarget-feature=+backchain`. Otherwise the result would be
incorrect code, due to different stack layouts.
