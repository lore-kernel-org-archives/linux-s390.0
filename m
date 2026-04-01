Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D62F617C;
	Wed,  1 Apr 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065553; cv=none; b=n/QM69B2iZZs4zVsPpozxyVZs7LWNHUgJPyCjzXfGcV0kqil35pWu6MqlorZWLqC+c6r1maP6vnkYOks6C8K3xHDcviG5e7axvDrdhY9UQ6DwJeslpR4SQ4G5g0i6AF2y6C/TIbcsK1XQpGE/rmaRR5JCFpr8j2sXsgjPNHR83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065553; c=relaxed/simple;
	bh=Ys0tiTV/MimY9rcS3fO7+7Fz6OuzBPLFyIyvmEqN0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX/pFI/M7iv0omqcUqBtHOBbHB9EBdhxb3q5ilXLwuqg5ti/K+vgw23DQ2f0DUGdwBczzQ7HcKF3ocsR0qPNPPQlqHa8FIS1zpViYYIyRj1vZrZh3DkFXLxLMeQQ+GEdcEm3LMLm06K5hvwslmK680FrKmwg0BXmNONDpSArxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZ2SRqBL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AZ2SRqBL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631A9b03568757;
	Wed, 1 Apr 2026 17:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=UMXhHMsuyBXezBwvcmb2s0m
	QvF+QT4HFq5MLBnVK/2g=; b=AZ2SRqBLfG5BnCykYNtBJewiX4rUxc8Z4ib9Q4d
	LiMDF6D7mw4RlBZuelTwlOOPldf7uYZHcZj83qk7y2WhJ0tSfIRBY+dmHnqWi3+F
	M9sTBS+DLGSfyaKLvbrUgEkIQ8/TeWZFKL7Fzjn3Z56vHfCz7nouieHQN7GZ6/mC
	NTx10cTG6dnIuhju1On2AO0a+JCGqgjJj22bjVnu1PFsFEt8TrCb2282nXEtHGgq
	VYInFyyGglx59NLjTjyMLSeCqBEQry2OXUP4UhXy8OiudBGQK464NNR+1GeynlVw
	Oo5oGCOOG46LTY+dOXZ5N2HLxzo2N/TzxOC4DL6CCkTHVeg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g21hg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:45:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631Fg6HO022291;
	Wed, 1 Apr 2026 17:45:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan6r91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:45:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631HjfhH46399844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:45:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4992420049;
	Wed,  1 Apr 2026 17:45:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3384320040;
	Wed,  1 Apr 2026 17:45:41 +0000 (GMT)
Received: from vela (unknown [9.111.87.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  1 Apr 2026 17:45:41 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1w7zdC-00000002Sb7-14uG;
	Wed, 01 Apr 2026 19:45:30 +0200
Date: Wed, 1 Apr 2026 19:45:30 +0200
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
Subject: Re: [PATCH v2 1/4] KVM: s390: vsie: Allow non-zarch guests
Message-ID: <ac1ZuhOhDuC_BDRo@linux.ibm.com>
References: <20260401151221.2272408-1-farman@linux.ibm.com>
 <20260401151221.2272408-2-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401151221.2272408-2-farman@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd59ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=RtfG19iD7UpRQCUH2uMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: J7yn467UIHThg1EpoOsm7VcMLIVpQhPs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MiBTYWx0ZWRfX/69OUyOLMpo3
 P1ssddpXmaLlW526ykBQzeulEJalsupjv03fqyxJCXCXkm9S57LEDA/ZIuLiebDpaG3uGrcRxV0
 n7IhEa70OuPcNGrSBlvhepfwvQF01wasv7Lzl955GqgAAZ1TAkKvvgxFfUywqAJ1o2ZAcvqJ1y9
 nA7baEgqnxCQAtBPFzJyphw1CkQ33pUXp7qmPLNlzzX1Bp5goed4WCSVLCaESHa3cYvo71r/I6W
 vAtFJGb5tU/W5yf7jcjCYZb9/w15mvOMb26HeeDQPbd4pK687kuGFjak+krg3ITPsLFmEAwj+gf
 8R4HosxPfcXdOTzVtLAWQ+15zSzEMSS1tss9HvaNmJjNDr4FXAzWg29MhXpyxycLLAxKo85fR36
 YvUxRcGwulfEdsL2n3G7vv+BnxuPtc3ArBBMV3iAl5haxKMHhrUQ/zLqpaiVaAmTPjm5WmIGwu1
 kEBsMIrKFcbl6/H8qoA==
X-Proofpoint-GUID: J7yn467UIHThg1EpoOsm7VcMLIVpQhPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010162

On Wed, Apr 01, 2026 at 05:12:18PM +0200, Eric Farman wrote:
> Linux/KVM runs in z/Architecture-only mode. Although z/Architecture
> is built upon a long history of hardware refinements, any other
> CPU mode is not permitted.
> 
> Allow a userspace to explicitly enable the use of ESA mode for
> nested guests, otherwise usage will be rejected.
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
