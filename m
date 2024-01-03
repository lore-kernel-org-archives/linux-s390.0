Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4281B26F;
	Wed,  3 Jan 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SaPq019C"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403FGJ7L029054;
	Wed, 3 Jan 2024 15:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=uQLMlCJImNqCHsdbyH1uNuuD/pxgp8sfzr8iuTucLj4=;
 b=SaPq019CclnrxcZOGHlF+y6KfWti90rmKVzvbF7iSOaygDdMV4C+apw+qFZtrY1RNxEE
 azNFRKbrx1MDw1lN1QXghgcREekBTO8GIQq+BeyJYWGnZid+2QH4cWGKQwb7ti5bKVpT
 x9va9tyLWLut38cu5YYqylbF6VXaY/2AFwc4sZJzc9sjyScbMK0zGZtcxIHCuI/0yc7t
 GtJAJNh84g3Ec5KwrO0mAoh5Hu1cfn2VzmmDzv7wer3fiqRUWd3nyB/fxGJ2U8cT3MfD
 +Lvd7EGW9j3bZZEgtVCBdpV0Iiv3T5bCuw0BbKQtnPZ/fFaOj39AyyA8LL80Yre+2IPu Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd8bjn4bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 15:48:12 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403FHb6r001646;
	Wed, 3 Jan 2024 15:48:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd8bjn4a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 15:48:11 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 403ERgVb019397;
	Wed, 3 Jan 2024 15:48:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30sjyrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 15:48:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 403Fm5rj41484920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 15:48:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B7420040;
	Wed,  3 Jan 2024 15:48:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44A2820043;
	Wed,  3 Jan 2024 15:48:05 +0000 (GMT)
Received: from osiris (unknown [9.171.19.62])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Jan 2024 15:48:05 +0000 (GMT)
Date: Wed, 3 Jan 2024 16:48:03 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: Neal Gompa <ngompa@fedoraproject.org>, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Davide Cavalca <dcavalca@meta.com>
Subject: Re: s390x stack unwinding with perf?
Message-ID: <20240103154803.24509-B-hca@linux.ibm.com>
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com>
 <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
 <20231027100925.9071-B-hca@linux.ibm.com>
 <CAEg-Je9+UnVsC9e_yDQmXTLNfZy+b42Smj3xobhTE5DiQjk_hA@mail.gmail.com>
 <20231030123558.10816-A-hca@linux.ibm.com>
 <CAEg-Je_eyVRFmtCtAH+BLvqfPut3LtZQL7NFASzv7Er=iJjqAw@mail.gmail.com>
 <20231109144834.11754-B-hca@linux.ibm.com>
 <CAO8sHcnqPojEJ7YVPzRWow5D9ELWpCaHG7kPeNoZzJb0QOOYXg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO8sHcnqPojEJ7YVPzRWow5D9ELWpCaHG7kPeNoZzJb0QOOYXg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I8B9p3M-V9y9rzxav69pC59uLNxqKohi
X-Proofpoint-GUID: -Lrt3L_-QDatHjlAjuxCDV9UhQ8VI-54
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030129

On Wed, Dec 20, 2023 at 01:58:36PM +0100, Daan De Meyer wrote:
> > FWIW, this is now upstream and will land in 6.7, together with a similar
> > patch which adds user stacktrace support:
> 
> > 504b73d00a55 ("s390/perf: implement perf_callchain_user()")
> > aa44433ac4ee ("s390: add USER_STACKTRACE support")
> 
> > Please let us know if there are any problems.
> 
> I've been trying out the new userspace stacktrace support on Fedora
> Rawhide but I'm having some problems getting it to work. I rebuilt
> systemd and all of its dependencies (specifically, glibc) with
> -mbackchain using copr
> (https://copr.fedorainfracloud.org/coprs/daandemeyer/fno-omit-frame-pointer/builds/),
> built a Fedora Rawhide image with the rebuilt packages and perf using
> mkosi, started an s390x virtual machine and ran "perf record -g
> journalctl --verify" followed by "perf report -g 'graph,0.5,caller'".
> On x86, this gives me a sensible perf report. On s390x, it seems a lot
> of information is still missing.
...
> To reproduce (from a s390x host system):
...
> - bin/mkosi -f qemu"

This fails with "bootctl not found".

Looking at the binaries in the copr repo it looks like the generated
code does create backchains. So in theory walking backchains should
work.

Could you please give examples what does not work, and what you would
expect? Right now I don't know what to look at.
