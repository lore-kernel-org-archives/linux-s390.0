Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F542089E;
	Tue,  7 Jul 2026 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410023; cv=none; b=NyQFWHNGyVH0atxmJp/RQuz7WaXsB4+RqNLCasDfM1hh+4XTbJt7tdl1bq76888S1ky+CImmKrwmHmSlggvVgmXHnStLoLnHA4X4a5ci3pTx+wz5OyOCBbtCkKCOPcbgk3UnJ8HuGN9JMY9smxy4+BD7nSF9egGrdVhQ9boPbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410023; c=relaxed/simple;
	bh=N2YBLQ2q+JlwFKcecWltDkVVJM0NmmZbDmKRyhij1Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et9zIw5UG+ANO2iyYOB0HMaoKDApMm2Qbw1m5DJ/+qoM39i/S4mTzsZXE6FUKjAyFnL6m3tbQxRLTbFb0rNC+zoxQSf2KAdPnu2eWZct1ARv7NS37LY2lOVJfRlYWrgUnlOeJXwwkhXwW+Y1Q24PaG9DpKMcjXgBYFCtwG/aonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lEtT2GXI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lEtT2GXI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674IDBi2725423;
	Tue, 7 Jul 2026 07:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1d2VBan8/XM9utBiTkiyVaE7rbR0Nx
	uli4JKEtTFc8M=; b=lEtT2GXICudrfpNmeInB/4FfnpK7pKmaAxmWJVtsDV2jW8
	Eh8wmRx6R+Gut8wPztuXxgw/vlh1aWc2qWYzXmllwEJ9b7eybg+TOTPiCrLfQSA1
	mRejkv6x2MjiLf8FtkcKMdf9GA+SpZv4q9J8Ef9IwNOAwS/8XMudUTzPZ9530jj7
	E2P30NheIfHRnCyp5u6UcWSnWeZ2v/RUtUHD0XtG09X+XR6xfqbqwnJGoLdDB/EH
	I5JBZfwlP1tSNJxfz6unZNfnO4140rrAgpWGUhN7QMAb9tSH3q+yhWzFKQBq5G8c
	idfVC7WVmYrm7qBoVQbc65heO+zAxR3zm3fuUmUw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqnkcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:40:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6677YaOB008650;
	Tue, 7 Jul 2026 07:40:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq1sg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:40:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677dxBI51446060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 07:39:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 941A32004F;
	Tue,  7 Jul 2026 07:39:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3504E2004B;
	Tue,  7 Jul 2026 07:39:59 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Jul 2026 07:39:59 +0000 (GMT)
Date: Tue, 7 Jul 2026 09:39:58 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 01/27] VFIO: take reference to the KVM module
Message-ID: <20260707073958.583632-B-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-2-seiden@linux.ibm.com>
 <20260706195313.GE118978@ziepe.ca>
 <akwaVzghHzi8o8fK@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akwaVzghHzi8o8fK@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfXysR8zSDAEOBH
 4x5xHPncdCmEZG24O4GLzeODqCXEzIARoD+2bCONtp17c+bEVbxINx14SyxMjvPB0O3V6nSaw6B
 9/a3WbPOJOja3fcoN0AJjkJnSchJKxk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfXyP4Hzwh8Cw5z
 dY4Mx1OFCm4qeu9UxNKbSgqE6ke0fKSKIGXo7qLDzhILzFZIZB9otVhz/rtalbVrMHNVq2JBJ4m
 IaZjbrOHZJHZQcBvxL6T1D/oeIoqPUo/ftxc79rqeIBf+Edrmae3WM+skt3jeaNrHlyp3SscJIQ
 6xZUfP7BpcWsltTRzoy/89bHHoUPZvETetwoUMzhdc+mpREEWHAAAINMxDpxCDRvAwfiHMt2yqO
 1HFCuXfibiDfImQyb7E8TT1bFX1mHdsYYkp4/1cufmCtuwUAJn4CCUMtN1Jcr7oGdFzXCrryAoD
 kynir/mGuVDLfNxxb0dkAYBtmdx2qoafg4EGRwy1E6vBKvtbXqYVjKpTDf0WMa4eeMghAGs3Pzf
 gC7CJziQuysqBLV3fgpJdQxACoUm5oOXtlTjiW2cyfXxa8C4ZKc0dY/NpRzWTtQgK7j0rC1bHKY
 mBQy5dnIwfFHl4drcDg==
X-Proofpoint-GUID: HSBOqlTnliJyzGOBDLWHxtevcP-AF-dI
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4cad55 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=Ubti9o167-X3AsrDlZIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: bmiDYJpYbB5YE7vJNJudbxkVJtNQZl-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070069

On Mon, Jul 06, 2026 at 02:12:55PM -0700, Sean Christopherson wrote:
> On Mon, Jul 06, 2026, Jason Gunthorpe wrote:
> > On Mon, Jul 06, 2026 at 10:52:01AM +0200, Steffen Eiden wrote:
> > > From: Paolo Bonzini <pbonzini@redhat.com>
> > > 
> > > VFIO is implicitly taking a reference to the KVM module between
> > > vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> > > symbol_get and symbol_put.
> > 
> > I thought we weren't doing this approach? Use the struct file as the
> > kvm handle. I thought I saw patches doing that already?
> 
> +1, my joking-but-serious NAK stands.
> 
> https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com

My bad, I did not cover this topic in the cover letter: 

I included those tree patches so that the rest of the series links in all configurations.
I know we will not use this approach to mitigate this issue.

	Steffen
