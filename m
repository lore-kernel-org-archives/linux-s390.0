Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C32264A9D;
	Wed,  1 Apr 2026 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065744; cv=none; b=nJW6spT37ry518iuI2gfknXGyxhMsEvOZl2rvKuZ9BKP81DPe+IgSFgVn35WGxG3wLxDOqjX5wgSjsXbGO2XkjSecOw36A9C7dutYDRN3tJWThjUnbwFsMLZ1z3awHKAU/HnwmospRRPCIROVyutjP/GgMx8jM2Q57Ke6Dq0dS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065744; c=relaxed/simple;
	bh=DNjg7W1GZatYc8UavnHj70lZCzxurZdRWaee62W3BLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojjiyBrC7xlIe11dRFukyrv9qltUKCfLadVwDmBNnlPyfUqrjcqsWZ/t3BgVO4GjvNVEWZzCRnd6CdWO8mAFs645SMeUvx9BN77n4xkIU/VdBVx6UBCF7uxYSwXBTJC/2M7oJrI3WlptMTBlD8epBtUpywS/525FSenWdfjb5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i2JxT/v5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i2JxT/v5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631ABVgh4032535;
	Wed, 1 Apr 2026 17:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=ReGclwLD3FvadjlMJVcSDdH
	Zqc1kdE3p2UNKdpmbKVM=; b=i2JxT/v5SBeOMoTF4eszYBzwTVPCdEoqyqfkp0w
	QuGoYZtqVrJdq2OMiKtK0L3n0j2fIdmUJVY5mBROqr+ocDM8FayMJR2oaQfvIXlv
	F3kMDTDpo1EszEddjg+vQHAiJ0IUn1W7fBkLiYpgD6LfsX+Bwuf4rfUGGC0Ar60C
	66FEZZOkEWbwAMV7iEPtWcorXlP3Y4HdJoSX+rXqY2Xl/s7FqdRjIL8mdP4emJHd
	v85YVRK+x1tFX7xkbmBPq5oJHyJ6b7E1g/zH5sc6JEMxoQ0pO2rcIielYtE5+WqP
	7YnjxHC2wLmrkjm5jDh/ItcMLZCH5YL9BO854orM9WaTuOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g21hxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:48:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631EvmZK005973;
	Wed, 1 Apr 2026 17:48:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy6vmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:48:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631HmsTQ42074372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:48:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2D7120043;
	Wed,  1 Apr 2026 17:48:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81E020040;
	Wed,  1 Apr 2026 17:48:53 +0000 (GMT)
Received: from vela (unknown [9.111.87.118])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  1 Apr 2026 17:48:53 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1w7zgO-00000002SnY-29iN;
	Wed, 01 Apr 2026 19:48:48 +0200
Date: Wed, 1 Apr 2026 19:48:48 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 2/4] KVM: s390: vsie: Disable some bits when in ESA
 mode
Message-ID: <ac1agAoEeWFKGgiN@linux.ibm.com>
References: <20260401151221.2272408-1-farman@linux.ibm.com>
 <20260401151221.2272408-3-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401151221.2272408-3-farman@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd5a8b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=IKBxkkiuW_2MPU9DICMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0pOmu5Kj2oDZUQ-3nbLffVO8eL3mQNFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2NyBTYWx0ZWRfXyuq0Tubdu35g
 mOMUxKtUhbMO9Dr7T6mDWcTCTgSmK5259O3IEBLvVEbLdIf2aje9kgcYWlX0QlInoXPlhSf8dHD
 MFmUJQxvXs69rlqK4uOVr9+zta4H0Hw/mOlV6c++Jjot8M4zyyXIVVBCJ5/SPwzRlKjNDmFgVnp
 DL7jJ4loIsmfaAOD/7buj8SHWL/QVgYfm4kGuVQ36a2KKSazBrqDZo4Yu5c9dDfmzyictDT1b+c
 V+AIjk+hpzHEtCZoSkJOBH0oIzZeAE/v2zGT9cSa6aCBpb1VfDtzzAmMMXUBS5HFByB6Mnt0rW2
 Qg5OonCu3b1UlV4qGW/G4tGc2ppeAPSoXMCLQslPiF63+fllVE6CeVvPCuC1gmoDujkYxS0AS5+
 BHo3Ap1XIZLphv8RM9YtXazxbyeKB8Ztb3msKGxPm1xNF6dwCbJ24WRieLL5kYlz5o9mMaN5kqz
 cAwOVlZ1XZMAIdw8Sdw==
X-Proofpoint-GUID: 0pOmu5Kj2oDZUQ-3nbLffVO8eL3mQNFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010167

On Wed, Apr 01, 2026 at 05:12:19PM +0200, Eric Farman wrote:
> In the event that a nested guest is put in ESA mode,
> ensure that some bits are scrubbed from the shadow SCB.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com> 
