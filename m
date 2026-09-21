Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22682496D5B;
	Mon, 21 Sep 2026 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995273; cv=none; b=El1bjPYy4ZNjJMUmo7mHJjSC2YNqMkUMzmWxDTHm2u1Np/+UosaYJzWWodRYsfPH4JxogjSVTRbylU4FbsfAm8ZDEpxT3ebpdnidXDr2g/iYN/1E3JSz/HPxq7/rzH31ltLRQyUHzCRGbLjzzATvTFN5hh2a8Xt46DIr3SRc+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995273; c=relaxed/simple;
	bh=uhQyl+/LqEZB9TDM5BK087GDepxqoXpw8oakvRBgEJo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8i20DWlB9DUndBZbXoGy391rbUHm/vlZePEl5eZ95QVeK8FYyGvJGYpTWY/SLTGs65ajuogxWhq47T01q/dxKZvcSE3ncbBRF90IJa16ef/AbnzfpiptPOlCruDKtGDFvwWYZbqspd/TzZpmKvU6rn+wC1EaYi4FesadI2Uwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IxwobdAb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IxwobdAb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5f7Z1169522;
	Mon, 21 Sep 2026 12:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Yat/EC
	Cccx0RfA1QRDBzCCYGKI44Lox9hn0q9f7g1Jk=; b=IxwobdAbsJU1pCmg61rIDi
	mB7zIKpyomZDA72J6I6+Q2ezL6rD029hRn/F2TnXptpyoxLl/yxt7MqNqjtUF5iS
	oCDGKfks7E9cInBxwUjkHa7X9LYEd83JF7OVsIYZtluxq+0A69QiDFJDWX3JS02x
	gByqDqVPKme+Na9DcQXUdI58CUzFbpTb+JqhdZRVkiSVuTpvm0hkKOC80XFGmWmY
	xLEnG9FDJ4vnLaakp5L/nA+LXoA1ISxw41/DGwB6YEOhKpx704y5gar6Rh/IeJhz
	CsTWu94elWOyBCIBVIwnil+xf3exR410AQbPvrQbuXAVteA9sUDJprQe5RRAbnDQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske18enq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:54:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlVNp1071924;
	Mon, 21 Sep 2026 12:54:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjn9t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:54:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LCsQlM41550188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 12:54:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E6352004B;
	Mon, 21 Sep 2026 12:54:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D5120049;
	Mon, 21 Sep 2026 12:54:26 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown [9.224.79.183])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 12:54:26 +0000 (GMT)
Message-ID: <28840d7e02c8eb0daa35d56553dcd8cbb9b3eaf3.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/sclp: Implement resize for sclp-vt220 console
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger	 <borntraeger@linux.ibm.com>
Date: Mon, 21 Sep 2026 14:54:25 +0200
In-Reply-To: <20260921122814.9DBAF1F00893@smtp.kernel.org>
References: <20260921121619.1354611-1-maxbr@linux.ibm.com>
	 <20260921121619.1354611-3-maxbr@linux.ibm.com>
	 <20260921122814.9DBAF1F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T27ovMFatyp6oSdPwkPLLAWxHvrUcCvA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MyBTYWx0ZWRfX2i52xgjshr/d
 S4CX6NF2qo1gP4zkFAx9KWVNXb68RAfUkzqDgW7KuPIqMgThWS9LO4ua2a7b6Hoyuw7kwtIj4du
 xKPBP4kRjfNIj+AHbhkmSb1tZjVuZvxIQZdNf1RaAyYgcscPI7yP0rz29w6SeTzsDdXFwQ55lqF
 MIaaxEtnWDX+SwCTjGLAwvmkJ64FqUqJd9wIaUG54Jy2kB8K8WCfYb6Z//bCtsSqel5+DVF+wCG
 OgbDzHeTX4kvUgBRLUtJHQahhIvCEIaq1sjsllY0kAQvhbO+2XEYbOJitJTsI4tuBYsomPTcp1H
 rKc8/TgwMXt3NQ29jIO07oocDP2j2cA3OnFNPw5mkh1B0D09dne6HGAoSQqdxmOnnSMiliLy0PW
 N+kIL5PHLnIMn54VPJDg0DE5tsyiE3lyAsJ/iqaEfTsfSx8Nf0dQojwDT5UF+AzV91XzTBaf2Tu
 sn74Ij4rO3pznAUH5Mw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab12906 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=oUpVr0UtpchP_V1RsEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MyBTYWx0ZWRfXzT4y1MhDJKck
 ZAT+GjzzuPEPhB8bnk2ET4lC55Ccildp6h2ZHVD9P6arnPd7x4Hfeh83hHWDD3dMwJq27dKrqeH
 JQRUqgeXI/66jM7PpSeqg3RsYP0aQ/Y=
X-Proofpoint-GUID: T27ovMFatyp6oSdPwkPLLAWxHvrUcCvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210183

On Mon, 2026-09-21 at 12:28 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> - [High] tty: UAPI breakage due to asynchronous winsize
> initialization in open()
> - [High] s390/sclp: out-of-bounds read in SCLP_VT220_SESSION_RESIZE
> parsing
> - [Medium] s390/sclp: data race when reading shared terminal
> dimensions
> --
>=20
> commit 13e18fecbfc8440743cc8dff7c08364db9a637bf
> Author: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
>=20
> s390/sclp: Implement resize for sclp-vt220 console
>=20
> This patch adds support for sclp vt220 resize events to enable host-
> initiated
> terminal resizing when using the sclp-vt220 console. This allows QEMU
> to
> dynamically resize the console.
>=20
> > diff --git a/drivers/s390/char/sclp_vt220.c
> > b/drivers/s390/char/sclp_vt220.c
> > index 7c168a66e4afe..d140617846a2d 100644
> > --- a/drivers/s390/char/sclp_vt220.c
> > +++ b/drivers/s390/char/sclp_vt220.c
>=20
> [ ... ]
>=20
> > @@ -543,6 +588,9 @@ static void sclp_vt220_receiver_fn(struct
> > evbuf_header *evbuf)
> > =C2=A0	case SCLP_VT220_SESSION_DATA:
> > =C2=A0		/* Send input to line discipline */
> > =C2=A0		sclp_vt220_handle_input(buffer->data, count);
> > =C2=A0		tty_flip_buffer_push(&sclp_vt220_port);
> > =C2=A0		break;
> > +	case SCLP_VT220_SESSION_RESIZE:
> > +		sclp_vt220_resize_sched(buffer->data);
>=20
> [Severity: High]
> If the hypervisor sends an SCLP_VT220_SESSION_RESIZE event with an
> evbuf->length smaller than expected, is there a risk of reading out
> of bounds
> when the data is accessed?
>=20
> This path delegates to sclp_vt220_resize_sched() without verifying if
> evbuf->length is large enough to contain the 4-byte resize payload.
> Since the
> event length is controlled by the hypervisor, could this result in an
> out-of-bounds memory read when sclp_vt220_resize_sched() reads the
> rows and
> cols fields?

Yes, but a guest needs to trust the hypervisor or firmware anyways to
provide it with correct data, so I don't see the point in verifying
data from a trusted source. (Eg what if the hypervisor implemented
load/store instructions incorrectly -- at that point there is nothing
the guest can do to operate correctly.) I could add a check here, but I
don't see the point in it.

>=20
> > +		break;
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > @@ -554,9 +602,9 @@ sclp_vt220_open(struct tty_struct *tty, struct
> > file *filp)
> > =C2=A0{
> > =C2=A0	if (tty->count =3D=3D 1) {
> > =C2=A0		tty_port_tty_set(&sclp_vt220_port, tty);
> > -		if (!tty->winsize.ws_row && !tty->winsize.ws_col)
> > {
> > -			tty->winsize.ws_row =3D 24;
> > -			tty->winsize.ws_col =3D 80;
> > +		if (tty->winsize.ws_row !=3D
> > sclp_vt220_winsize.ws_row ||
> > +		=C2=A0=C2=A0=C2=A0 tty->winsize.ws_col !=3D
> > sclp_vt220_winsize.ws_col) {
>=20
> [Severity: Medium]
> Is it safe to read sclp_vt220_winsize here without synchronization?
>=20
> The global sclp_vt220_winsize state is updated under sclp_vt220_lock
> in
> sclp_vt220_resize_sched(). A concurrent resize interrupt could
> theoretically
> result in a torn read here, mixing old and new terminal dimensions.

There can only be one open sclp console at a time. When opening an sclp
console there shouldn't already be stuff going on with the tty that
could mess with this. Even if this were the case though the tty is
locked by a mutex so it can't be locked in the interrupt context.
Furthermore, this behavior was already present prior to this commit so
even if it were an issue, which I don't believe it to be, it wouldn't
be an issue of this patch-set.

>=20
> > +			schedule_work(&sclp_vt220_resize_work);
>=20
> [Severity: High]
> Does this replace a safe synchronous initialization with an
> asynchronous one,
> exposing uninitialized dimensions to userspace?
>=20
> Because workqueues execute asynchronously, the open() syscall can
> return to
> userspace before the worker thread executes tty_do_resize() to
> populate
> tty->winsize. If an application immediately queries the terminal size
> with
> ioctl(TIOCGWINSZ), wouldn't it read 0x0 instead of the actual
> dimensions?

True, but I don't consider that to be that much of a risk. There are
situations where a 0x0 terminal size can occur (though unless done
explicitly it's usually considered bad behavior) so applications need
to deal with that anyways. Most applications just fall back to 24x80
(the default). You can't assume that sclp_vt220_winsize is necessarily
24x80 once you open the console for a second time. That said in the
case of opening sclp_vt220_open().

>=20
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0	return 0;

Also you can't have your pie and eat it too. In suggestion 2 you doubt
whether you can change the window size synchronously and in suggestion
3 you mention that if you change the window size asynchronously and the
tty / application running in the tty are up really quickly and query
the winsize quickly enough they might receive an outdated result. Pick
your poison. You can't have both.

What I could see as a possible change would be removing the equality
check on tty->winsize altogether and scheduling the work
unconditionally, elliminating suggestion 2, but accepting the transient
false winsize value (which I doubt btw to ever be relevant in real
use).
