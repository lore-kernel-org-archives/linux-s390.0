Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473343CCFC4;
	Thu, 12 Mar 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331741; cv=none; b=tHuOToOAq9lLw2dxg0GJe//gs3auAYby7Ee2UWABFav7xXMmKxk5rDb6d4/W5YrDUz6fWRGy/+smaMDiTuAeUjUy2BElRIUWWczF57jqloxYWvW4hTfZl6HGfDDjiTWKklivC15E2+wql001aGDYwsZwh7ktfR0WOjh4VsgiHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331741; c=relaxed/simple;
	bh=NLE0tXe03+smplfMBeazWwX+GyXQOTbA7CnQJP8EfPc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=d9vJ7TKaAov+UIdB17HmdTYcVt775HaHah8GwZ0sDGKHciX/1KhCfpvTxA2cYzpVNWw0tHFFlC1Ud4lRj/Y+WUU19/ZYvBuhKaf2mlipe2u5zgjg6ggBq++lJB95wQrusC9awQROCcjCMM6v0IF8vxiZwdVRLLBMGyJD1BAqSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cbhRaBmG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cbhRaBmG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CF7R1j2308232;
	Thu, 12 Mar 2026 16:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bpARq/
	22MlkdkIcDYt3KaU2yN2WmyKPIBxyZS1yDLSM=; b=cbhRaBmG7CfCW+OmsuYhkY
	YCLEmeZVQQFXXQfhTbVdmUGBJTi4zAs2pFlmGsc6naTXMyzthVFVscq6lny3zcv8
	4L5zngnOkUAT6zBhEb7JNPPgdcENjB/U9oRf4GGM0OBLUUdGht72CkEFWGAAIY/v
	1q8caOOLYMmok6/g+GP1gjduNx6ISLAvgyzELj2QoTI98lnFJLd5jtaRztLUjA0S
	1Flkq3ESiMgFzvi90gg3vB0M/BlhRPIFxOusayplXUNuDr248CcHVY0rLLgiMyJQ
	g029VNB0RXRVo9yB9JnwfuIPNXwCUfhQaUo2TKMUK5XbIAvrYrF0kelc7i28TrzQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96bg7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 16:07:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62CEVxS3006091;
	Thu, 12 Mar 2026 16:07:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9k0ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 16:07:44 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CG7hJc25100956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 16:07:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2312658056;
	Thu, 12 Mar 2026 16:07:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C05B58052;
	Thu, 12 Mar 2026 16:07:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.148.157])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 16:07:41 +0000 (GMT)
Message-ID: <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Eliminate weak definition of
 arch_get_secureboot()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg	 <eric.snowberg@oracle.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman	
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
	 <chleroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik	
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Paul Moore	 <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>, Coiby Xu
 <coxu@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
References: 
	<20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
	 <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Mar 2026 12:07:41 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDEyMSBTYWx0ZWRfX6UYp50rgI7wC
 LaHgcaw2Q4XsqduGci08N/mmOkAcwyd88LS27/zQo0/FEc02AxD1omQE3M89xwgC6RjNi415jns
 AX68w12J6/N1n28xLuTJQE+z7uPWuUxu+qdcd8nG+95r7XjiIPwsFa8o/ha+rEX+wKgbQ66SQQ2
 +GJiZVL5H+kAiKF9Bbc1KABQivndGOYBy0cqGS6jMfGPKbnP3j5GlnOpIMDls7R8UBgbFsEa+51
 2kcR6LjnDSHHWHn+zfCyO11vPDJoE6Mb6a9rUEBZMRAUMVNJrx9Z+TB5q3PwuPTS9vSk94Uhxif
 tBWallf8Pl0UObKLXM2Zvnwno50mYWgu+bT0N0bLxU5g/Ooh0TersgoW2otvLQ0zrg8ZX4bUBpl
 +DcbtwoZuctBfKpU+rLLkJfPARE5pnTb/RnvOiNNXVX2kKoFpCM9md6DYnEcGXibZARx1TKgtUq
 2XhBEvszNA5u8dDJtTg==
X-Proofpoint-ORIG-GUID: hgxryyvWqyznJw2FLc1GUC70EGzpkxFi
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b2e4d1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=mHT-XC4fkXfe5xHyWCkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mzVZk3RoAFTvORT2kumWTYvu4FMdCjI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120121

On Thu, 2026-03-12 at 16:03 +0100, Arnd Bergmann wrote:
> On Mon, Mar 9, 2026, at 21:37, Nathan Chancellor wrote:
> > security/integrity/secure_boot.c contains a single __weak function,
> > which breaks recordmcount when building with clang:
> >=20
> >   $ make -skj"$(nproc)" ARCH=3Dpowerpc LLVM=3D1 ppc64_defconfig=20
> > security/integrity/secure_boot.o
> >   Cannot find symbol for section 2: .text.
> >   security/integrity/secure_boot.o: failed
> >=20
> > Introduce a Kconfig symbol, CONFIG_HAVE_ARCH_GET_SECUREBOOT, to indicat=
e
> > that an architecture provides a definition of arch_get_secureboot().
> > Provide a static inline stub when this symbol is not defined to achieve
> > the same effect as the __weak function, allowing secure_boot.c to be
> > removed altogether. Move the s390 definition of arch_get_secureboot()
> > out of the CONFIG_KEXEC_FILE block to ensure it is always available, as
> > it does not actually depend on KEXEC_FILE.
> >=20
> > Fixes: 31a6a07eefeb ("integrity: Make arch_ima_get_secureboot integrity=
-wide")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I pushed out the patch to next-integrity, but am a bit concerned about=C2=
=A0the
definition:

+config HAVE_ARCH_GET_SECUREBOOT
+       def_bool EFI
+

Has anyone actually tested this patch on s390, not just compiled it?  If so=
, I'd
appreciate a tested-by tag.

thanks,

Mimi
