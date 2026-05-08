Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487101F8691;
	Fri,  8 May 2026 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245700; cv=none; b=QNmjertwiYe8t7OobBFwHXwODbd2aHcbNk942ENWamDLJztKDzN7DhYHxPj7KkPiNqMD4dyA/SkTvpkOSCHR9liDLyG+qFEfgwisxToMircYZcGG/aN7R7HI+9DX41SykwLBmBMPx8sLeOMGv815SufNmB0i87/BZ6w67EBpKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245700; c=relaxed/simple;
	bh=ITYGj1EjPgggdECL7+NWLs5KvF5gFyktyuXpGKgy1WA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X7E4OAllILL95lqf5JSzcL9scGXhkrwmQ5rW0kpt5c+vAlGACz9spLICzUswxAC2ZVGQZGdbPc3hUHV7jsQHt4+n9G8fZi5/rpCkwKK9sYDAUEjkLHfFV54PHCbHhVf65+MxYvlzdVHfeEk9fiYne8g/EHHOBD9uFmLZuWSa0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iNwJSew/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iNwJSew/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648124QG2805903;
	Fri, 8 May 2026 13:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EJBZh8
	NphQAerlQeRvJ0i9+Rxs6rH3UaZ+wSL42Cy6c=; b=iNwJSew/Qu/2PeeoxyTXV1
	WxzWegktzeQR3exKGrehb9LMHwlI+xsBuGvTrCPliZrOQGrVWZuExtigzy9vUNX9
	NJhrNQqufSJ+jF6wUNvP3Mj7xbqOHkJ2OV/WLxaNu68qGNeq9bWlzB1A4EoCQ/BZ
	I58ovpYS6q4BECfbXeBwa0lFVf1hxynttKUGky1mc6RmSmAC5eG0V6lV5PGXLRGC
	+erZqhD9QKVJ1QTGZ2bHYk6YwYkyjTx1kv38Zp/3fQTND1QAkTTAa2dVEJGKzEH+
	rkHTWKVLSIDOSCj6M1Aiu0OJoZAhVPBxLX7Na7HlwsqVCzqAknka+2V/Dc+PHcCw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7uu37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 13:08:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648CdcOY018067;
	Fri, 8 May 2026 13:08:16 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgr32m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 13:08:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648D8F8t28705444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 13:08:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FE1758052;
	Fri,  8 May 2026 13:08:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 775245805D;
	Fri,  8 May 2026 13:08:14 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.111.34])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 13:08:14 +0000 (GMT)
Message-ID: <66f7c47f9931bfc9be47c7f6d02861bd3f3f37e8.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] KVM: s390: Toggle operation exception for
 userspace
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
	 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Date: Fri, 08 May 2026 09:08:14 -0400
In-Reply-To: <1ac58dd8-1b06-42b5-9a19-67620b4fdc25@linux.ibm.com>
References: <20260507200836.3500368-1-farman@linux.ibm.com>
	 <1ac58dd8-1b06-42b5-9a19-67620b4fdc25@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzNiBTYWx0ZWRfX+E+dYpv64FxU
 mllZkS2TnA+/w+Bapd42mcMurrpBz2rLq6U81Ts7v6FH3eDgySGwEodOpGqbM89maacOruKEtPc
 ctRwm7ypM/9Ookl27eMZHKHU2lhNgPw3EOVeDICw2JCO1QfreFSKvqDQgR2AgCN5WUliW1hNULI
 kXWkYuyioWSBOiC8cHoFoiY72/M0ftA4jTkk1+qplidcCPsPwpIfnEIyglTqFT9XCJUmJQmQKNy
 mVXgapZrQpHh8aeO/1YZfGpFxDHbrGNkXwTh2tsEl7LtTAFbpL97EOlUf09NjLTmd9CqTOsf9dU
 nVnsrUf9HkJ4ckyDxKLjbh9pnQu/MozVTIGU8loV4eBLBb29iGzv4MY8DM6XzrZTgw2uLCgXthL
 gFLFMIafIqVdii+Xk5rDqOzehcDOZtZW2Vvw0xIEob65lqGVCuLhjCfaaqKcN659gAnoCjunXYe
 AI1maRAnty0TK/DsrhA==
X-Proofpoint-GUID: eYBVaZe1vQyDAXhlrSyLS6dIPjMsYYbX
X-Proofpoint-ORIG-GUID: eYBVaZe1vQyDAXhlrSyLS6dIPjMsYYbX
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fde040 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Jmiu7mG_WmB9V10SlMQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080136

On Fri, 2026-05-08 at 12:07 +0200, Christian Borntraeger wrote:
> Am 07.05.26 um 22:08 schrieb Eric Farman:
> > Claudio, et al,
> >=20
> > Here's an update to the USER_OPEREXEC patch I'd sent the other day.
> > Besides the addition of Claudio's r-b (thank you!), Patch 1 is identica=
l.
> >=20
> > Patch 2 contains a couple of new selftests. As it stands, they all run
> > with patch 1 applied, but I put the failing test at the end for if
> > Patch 1 is missing.
> >=20
> > Patch 3 is unrelated, but is a minor typo I stumbled on yesterday while
> > looking at this. It seems small enough that a second `git send-email`
> > command seems unnecessary. :)
> >=20
> > Eric Farman (3):
> >    KVM: s390: Toggle operation exception for userspace
> >    KVM: s390: selftests: Extended user_operexec tests
> >    KVM: s390: Fix typo in UCONTROL documentation
> >=20
> >   Documentation/virt/kvm/api.rst                |   2 +-
> >   arch/s390/kvm/kvm-s390.c                      |   3 +-
> >   .../selftests/kvm/include/s390/facility.h     |   6 +
> >   .../selftests/kvm/s390/user_operexec.c        | 110 +++++++++++++++++=
+
> >   4 files changed, 119 insertions(+), 2 deletions(-)
> >=20
>=20
> Independent from this series (which makes sense on its own)
> shouldnt we add another fixup so that we send these kernel injects also t=
o userspace?
>=20

Hrm, that's a reasonable idea for the ones in priv.c (intercept.c are alrea=
dy covered, see below).
I'll see if I can find a way to unify (and test) them.

>=20
> git grep PGM_OPERATION linux/master arch/s390/kvm/
> linux/master:arch/s390/kvm/intercept.c:         return kvm_s390_inject_pr=
ogram_int(vcpu, PGM_OPERATION);

This is handle_sthyi(), called by handle_operexc(), if stfle.74 is not pres=
ent.

> linux/master:arch/s390/kvm/intercept.c: return kvm_s390_inject_program_in=
t(vcpu, PGM_OPERATION);

This is handle_operexc(), if neither user_instr0 nor user_operexec are pres=
ent.

> linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_pr=
ogram_int(vcpu, PGM_OPERATION);
> linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_pr=
ogram_int(vcpu, PGM_OPERATION);
> linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_pr=
ogram_int(vcpu, PGM_OPERATION);
> linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_pr=
ogram_int(vcpu, PGM_OPERATION);
> linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_pr=
ogram_int(vcpu, PGM_OPERATION)
