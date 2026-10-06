Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805233939C;
	Tue,  6 Oct 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299993; cv=none; b=LpWN07Bq9mlq537egI4DoWluGN7G2HRukQcKhc+HNpCcqus0oEFohA8dzE0+Vpi+rn1RWvSaZ8ibPq4YUfFEqbVw703fjgrZBgIef4fyW0HZKqkblVeDa2qgSJxIFaIGl5BkOGipewdKbYlFEItvmgAu8DBft6gEc0IZAg3WrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299993; c=relaxed/simple;
	bh=3fvKYikq/O+7NV1fblX1fDVc5rdFesI1+Sal7b07mAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXVKVw39ThyfKWM38fg8CU+B+wXo5USQKYlqcT6477Ap1hPysV6VXlbDUe1DctAelQyPm6wrMc3y04Zj0kjEJxcprPwIt5OTzsdZb4ryE+NM1NQGNHyrxZkDqlnS/OS+4sVLMOqRrLG9lVp7+f7pn+9SURjxAwY/Tim/BZOUOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D7U8erG7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D7U8erG7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZX8L3974867;
	Tue, 6 Oct 2026 15:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=mvzM3pUYVnqKucdXNTH1EQb
	Xu28c7Tgb1+5jwmfWUog=; b=D7U8erG7cVcWzMYHHFnGfBOFArKXm6BO4rXOyFS
	IphOFzzi9xhZMlxbWyWytEydEjKV9XSxfbcFG3mHySUInL7qCC+IRNghno4Rh2w7
	05VwZFe/xktiAMfMl6AkjQh4ODvadSyTIeBXj/cTNz/pIIcL2Q0YxlB77exGCIvG
	wmj1HWnoC4A1/5rtRUQHHb0EfgMi5xCqnPYKogYvYzb3753nSNBcft0F/jQGa4hm
	r4Lw9smL93qUUTE+KHxtCqxzOJYFhQF1H9OqgUZ/JGqn4tGb8IvM76eKXvq+RKQQ
	j5rbQcxzkim1UxQXfVAdBeSpeKn5EvKvqArA8YzZtcmVvuw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5gqrn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:19:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHWZb424982;
	Tue, 6 Oct 2026 15:19:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqya857-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:19:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696FJAbn38732158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:19:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B9F22004B;
	Tue,  6 Oct 2026 15:19:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D2F220071;
	Tue,  6 Oct 2026 15:19:10 +0000 (GMT)
Received: from vela (unknown [9.111.1.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 15:19:10 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.5)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1xE6wg-00000000k1c-0Aw6;
	Tue, 06 Oct 2026 17:19:10 +0200
Date: Tue, 6 Oct 2026 17:19:10 +0200
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
Subject: Re: [PATCH v9 01/24] KVM: Make device name configurable
Message-ID: <asURbogjgPv0giOu@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-2-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930173441.66762-2-seiden@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MCBTYWx0ZWRfX9+etyTznx5pA
 7OdEta3SyWkep5S3mhGPAF8b/qBsQtEBqyFeHQvm/cJxhSHUB57bq0yD2jOz21Yztz/haMn3qsN
 UQ30nMjC+ELEH5jyKa3WSY6Gy6xxA+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MCBTYWx0ZWRfXzyszztP/S3VL
 DnwvC4iQ++cQ7h8blXPxFT1ApfG2ew05X4fJs5qH8W+1k39LukibrerQ3kWjNbdPLFnpPcSMmZS
 TXTXUbILGMKgaWdiSiEztYxH7/fk5pqcqOyxqWyKRXxV5Q5QXVheX5D3/dOP51UzWxmkFBTZMkg
 KfwcVN3Rv0GvulG/F0jmD8QSNV2pgkWn9sRM3oKRYaePCv0BJhVoFOUhXz/HTWren+itfaskaTr
 2AGLy3wQ6PnBqsvPp+qeTqNhScnS7xozQfKaMXFxDWcZFMx03txZlyJYkVA//biH4lsf8ZEOGYl
 ESLfMHoqplBIS/LubNBbJ9jtdVeShCUMOOEwtyWzr9IBTVJfnlPjP5GP8x4us8J+TcD/mNLLHz7
 BzflqX9AHK2TptCim0DtgQY0J1UINhHoK/sTMEwdDJDlczYFlVpI6yh+L+GIdc+7h/JUAIXBgk1
 jBeo4oUKbx7j1dcu2IQ==
X-Proofpoint-GUID: jHucc80oTy9NR3f9_0VZvSIogY6jBP99
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac51178 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=OeVGTaGK0LzumyUwHG4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ic2jutYozjRQ-XNF-uBcpKXBhAdCiCUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060060

On Wed, Sep 30, 2026 at 07:34:16PM +0200, Steffen Eiden wrote:
> Allow KVM implementations to choose alternative device names. This is
> especially useful for architectures providing multiple KVM
> implementations simultaneously. Architectures providing multiple KVM
> implementations must compile the KVM common code once per implementation
> and mangle symbols.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
lgtm. Thanks Sean and Steffen.

Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
