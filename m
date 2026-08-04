Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69237B007;
	Tue,  4 Aug 2026 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846186; cv=none; b=qJHNN2RduL8WRAgjhB/dIeQip1m9sdk3YQGTgXe9QuuBqp5pj7FzYwHQfDCZBa2WCtfAYs7yOLYhWchtLC6t7uUNoFVU1YN4BfD4Y+egcpIupf4+tKhFN8eMpcfP0a/8dIXmuITRDlE0dbBgMA8W+dNuQ0liMvxUawybWIKnN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846186; c=relaxed/simple;
	bh=ILjQ1klajNHNi/Hp0WHcNA8nfHTy9jiYs9rphP7HH4A=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=X1Ausf0gBblZraKjXj2TzfH60cartaEn0MDW3SWFWpQBvS8d9H+A/YWTXY/91eKuoIoBOIOhr/SslAsx3kEwGC9s/tD5G+VoHWBj2zkHaxs7nWw1lUxglawsGbrWiCJl0oOZfsq4m3JdMLvNh57/KM/rt6GWUjauKrg8lm7UZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T/GTo3xL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T/GTo3xL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748Hw0h383467;
	Tue, 4 Aug 2026 12:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2yn9iT
	IwmuDOuoY0Aj+NNZNYkSQ6S57vFiPr3j44Xn4=; b=T/GTo3xLRs71j7fozL3FQD
	zVa8xGgUVhZidQB+5Ls6ojGlUGC8UD6qqLe8JoaG+GbYty9Vl2Lyq/TOXUmq1Sz2
	fW/wiwKekGfsXkA9nm7ru26OmTeX5nRuVJ8+wVCmCWTyR3x1q9WRHJV7bsXIS7S0
	URrbXirG/hOWf1u+oYj8SrGFMOEripXgbShjIPjwI5BjUo1ZshfLEzxOfYdkVuea
	ApOYWLFPsdYvTeZzK7tDIe/5uQb7L1FZsqPe64bq4OSGfkEeAZfNKDRGKxCNLnED
	75jhk9/hv1BESNy/cxite24eoQC7wOL4ff788AgiLvJ5p3/LH/m67RiY3c6kCzBA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euna8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:22:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674CBQTi006150;
	Tue, 4 Aug 2026 12:22:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg9nfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:22:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674CMWUX31261420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:22:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 429BC58068;
	Tue,  4 Aug 2026 12:22:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE22D58052;
	Tue,  4 Aug 2026 12:22:27 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 12:22:27 +0000 (GMT)
Message-ID: <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Danilo Krummrich
	 <dakr@kernel.org>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev	 <agordeev@linux.ibm.com>,
        driver-core@lists.linux.dev,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Boqun
 Feng	 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
        =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin
 <lossin@kernel.org>,
        Andreas Hindborg	 <a.hindborg@kernel.org>,
        Trevor
 Gross <tmgross@umich.edu>,
        Tamir Duberstein	 <tamird@kernel.org>,
        Alexandre
 Courbot <acourbot@nvidia.com>,
        Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>,
        rust-for-linux@vger.kernel.org
In-Reply-To: <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
References: <20260803180931.97202-1-ojeda@kernel.org>
	 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
	 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
	 <20260804071330.24760Aaf-hca@linux.ibm.com>
	 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:21:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: SdI49qhV5G_pvcfL2NPWqhy6HFmyBz0w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5OCBTYWx0ZWRfXy2H9CE/gCA4x
 wITqz9PvflpXkvtszVZAajsYc2Osar2LkXmWamWxQd/tLKVhiAyHNfApVlWx5/ogUzxy5qTmZe/
 Zl2H64cHFjnIRmXUNOgk9Yd/lxZO8+c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5OCBTYWx0ZWRfXywaEexH+ijLo
 5+62BjS63IWuPQ9zNPiMJ1a6bRj0nv4JsqZyVXNZcsDNFO/yrONMGp5437AFvvK5bmKZHL5WB5e
 Pnrpszf0JDXQeaTen67SeTkAnUOpOkPmN7EDSR4s3T6zoAh5dnagOOwDLZ66BLFMUAQLPwxmLYu
 fkPEC0pfEmUYK5hdvBVPNUbcH1WWsiHV/r/ocA997KlVqyVDtuo1q18qvFb7wV1O0zAkk2Fra00
 f86ALO5XJzon9dne8FfaOdmSlFr8OXn2tWON9pHddD+Bm9psbqMYNV37FwCgDb+lnwBQGvd2oua
 e8qPgrtmO8DwhYqvlkYlapVBL2zmwMhos8q6vwkk7PqVRWE0n6K/wgYVD+zdG42U4U8W95z6HqL
 8nhRiOjInxoiUvtIdgOLGmQCNXNe1HQAVkrYcQ791TQXqzqBC45bRwyydDtquKuq9Cv1t5edtU9
 L/te57OelcHA9WpoGXA==
X-Proofpoint-GUID: phJmksln1t2bJJahL0TrPyV7L2iq1sEt
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a71d98b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=-p9r9kYiykyg8HHu3hIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040098

On Tue, 2026-08-04 at 12:36 +0200, Arnd Bergmann wrote:
> On Tue, Aug 4, 2026, at 09:13, Heiko Carstens wrote:
> > On Mon, Aug 03, 2026 at 10:09:08PM +0200, Danilo Krummrich wrote:
> > > On Mon Aug 3, 2026 at 9:56 PM CEST, Arnd Bergmann wrote:
> > > > In theory you should be able to use rust code without PCI MMIO
> > > > support, but I can't see any practical downsides to making rust
> > > > 'depends on HAS_MMIO' to avoid having to add those #ifdef.
> > >=20
> > > I think the implications should be minor without making Rust depend o=
n
> > > CONFIG_HAS_IOMEM.
> > >=20
> > > I just sent out a fix [1]; the only annoying part is [2], but we shou=
ld change
> > > those doc-tests anyway. For the one in rust/kernel/io.rs we already d=
id in
> > > driver-core-next.
> > >=20
> > > [1] https://lore.kernel.org/driver-core/20260803200249.3494259-1-dakr=
@kernel.org/
>=20
> This looks like you still provide the rust version of ioremap(),
> turning what is supposed to be a link failure into a runtime
> error.
>=20
> > I'm wondering if it would make sense to make HAS_IOMEM always available
> > on s390, even though it doesn't make too much sense without PCI.
> > But at least it would make s390 again a bit less special.
>=20
> I see that with CONFIG_PCI=3Dy, s390 already falls back to
> generic_ioremap_prot() and just maps any phys_addr_t into the
> page table as PAGE_KERNEL, regardless of whether this is an MMIO
> address or not.
>=20
> The simple change below would just extend that behavior to !PCI
> and make that consistent with CONFIG_PCI=3Dy on machines without
> actual PCI hardware. Of course any code that might rely on this
> is now a bug that likely never gets caught at build time.
>=20
> This still relies on implementing the __raw_* helpers as nop
> to have the same behavior as the PCI=3Dy version, as the generic
> version would just end up dereferencing the invalid pointers.
>=20
>      Arnd

I think there is also an interesting interaction with memremap(). That
calls ioremap() under some circumstances and it's a known issue that on
s390 memremap() will work if the PCI memory-I/O (MIO) instructions are
enabled (e.g. on modern LPARs) because then ioremap() actually maps,
but won't work if they aren't enabled. With your proposal it would also
work for !PCI. Sadly, without working on the non-MIO one still really
can't use memremap().

I actually have a prototype lying around where ioremap() always remaps
by mapping the address cookies much like we do for user-space access
via the s390 specific MMIO syscalls and then doing a page table walk in
the accessors for the case where we don't have PCI MIO support. That
would also allow us to implement the s390 MMIO syscall via
generic_access_phys() getting rid of quite nasty inline assembly and
over 300 lines removed in total. On the other hand it would cause
overhead for non-MIO systems and sadly this currently includes all KVM
and z/VM guests which is why it remains on my prototype pile. I haven't
actually been able to measure the overhead but clearly more work is
done.

Thanks,
Niklas
