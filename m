Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA683B7B8E
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142927; cv=none; b=NGSPLUxjDFtU3LWl8wrBhfIc0JC3W5c12I2kpDucWCaEeign2+C3kS9esSZvhTAYaN1ATYhNsr2TzkE6b6yipvfrzeVZmmkCG3Ivj8vKdh653o9Ywgh7vOlFBQGxdgGCyoVxeuhkr2jDnI0Vcrl0FzafLhjewrFsg+iPZlgGJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142927; c=relaxed/simple;
	bh=0BohINyRZLNlFiLIBaQ4JuXUKgZ+Z/UHnWJ7YeBa7IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYjfRSldJczSZoKuo35ckEstdksWYIfJ4SYjoy9tToQuhtNeDuZOAHl/7CetOOqoaIBvkbtOdxxosN4we1z0TMsS7EFfAl9+mClW9fbSMZbUpY2NVdZTLNCrmwd6/sdqDYrWsxTH12tOuk+QeqahclUnH0nRqpajnuLVHtvJbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ONzh8h4j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ONzh8h4j"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDILnE2921905;
	Mon, 22 Jun 2026 15:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=5ifq6cRP6U2Eq4Ov3xC00dx
	LGdU0d2vxEpFm1ni9fRY=; b=ONzh8h4j9oWE+sDKbf/C19wf8713qM9c8g2fudZ
	nnothHRLyg8FyDllagam2CSL6HY9KGfdy+1ZV+/5OVyo7BGpZpUHZ++aKr4V82zM
	oXANyhRn8HX49IgPyTlrvJnyjPzGVww13wvBb47xU3wRYVRiD7sy7ObL2dE+4yqT
	/xwlcgg50/wmXOYcJ6oalDAjRfyE3cLqzf0k47MKijEyqMjqlCZulSjUEQRuDlYc
	hJM2VhF2d9/QWGZkiryblR0ZkhPfHOTOTTpGTl8soUHEF/LUKZexawFPZ20kCBW5
	VS7k2znIPLkJD7t8d0LgFECPWpKoNFUnimdMdRSWNioGz/g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4a1sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 15:41:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MFYwhs018943;
	Mon, 22 Jun 2026 15:41:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dfxpcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 15:41:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MFfnQO61210982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 15:41:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A42420043;
	Mon, 22 Jun 2026 15:41:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48BEC20040;
	Mon, 22 Jun 2026 15:41:49 +0000 (GMT)
Received: from vela (unknown [9.224.91.188])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Jun 2026 15:41:49 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.4)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1wbgmS-00000000ifL-3tUB;
	Mon, 22 Jun 2026 17:41:48 +0200
Date: Mon, 22 Jun 2026 17:41:48 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Finn Callies <fcallies@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 10/17] target/s390x: Support protected key AES ECB for
 cpacf km instruction
Message-ID: <ajlXvL0AiHsi6mcG@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-11-freude@linux.ibm.com>
 <943edaf2-801b-4124-a7c7-67555ba2ac28@linux.ibm.com>
 <78bcb32f11ecd35f1647e4a11b12cdf8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bcb32f11ecd35f1647e4a11b12cdf8@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1MiBTYWx0ZWRfX45FSrZDYo8Ap
 FIYhe/Bzp5G7zO3dRtLk2NtLLm2mV2vQ1ueXdmgkMUxlDUjYfeVYJY0Vl1kufYjqVoA7seVDkkl
 cOic3VdHM8qw8emE3YeKN2sY6QtzHLs=
X-Proofpoint-ORIG-GUID: QoJIPMJVLJNJR0lBIkbhw3sy5uJgh6au
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3957c2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=oeg37K0tJwVTKOOyiTcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1MiBTYWx0ZWRfX4vKVcarwCem+
 fqWu2Du52Edfv68BhPI3ZCoa1xSmRHYyBWQ3Eg+Cz0VNeKtdAd8cgR5cBcO2CXRtaiG0ztrb4Yq
 fabq/XqN93eEQbSR2NY9lwbmT6A4GkADo0JbJqCXhqNpHtNyBUhOwWgtSjWaFKrDa98tZFTMdWo
 T8taTWj2Nnp3Ba7Mtgo1OoJau6uCaE9Zj+WRLWutlI21t44i4mUVwvYRd54qVTO/c/LxwTq/SjM
 8+LF1TFdSy1eTZ8iyS17HJc79UN2eNFQupBz0gb7JaGm8mmQSWUqbPMsuRou1XdwtnClLjnsPGo
 rT5qzlgZAzmHKNNNnf1Zln9gtvEBiICOe3frJwpVHBmJ4nm/FVrH89Pn2FefcBrbVBtpcJc4UUR
 hEsisNNo9tXmoelmD7pWVePMtt3UwxkzB2Vgkupu49CdT4QoQg46HKLv+1joJtWjUiLv6ZmNJW+
 9INp5i0nc/KKliLqAjQ==
X-Proofpoint-GUID: QoJIPMJVLJNJR0lBIkbhw3sy5uJgh6au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220152

On Mon, Jun 22, 2026 at 05:05:28PM +0200, Harald Freudenberger wrote:
> On 2026-06-18 07:57, Finn Callies wrote:
> > On 17.06.26 11:48, Harald Freudenberger wrote:
> > > index d3e69aaca6..71e0e41d6e 100644
> > > --- a/target/s390x/gen-features.c
> > > +++ b/target/s390x/gen-features.c
> > > @@ -924,6 +924,9 @@ static uint16_t qemu_MAX[] = {
> > >       S390_FEAT_KM_AES_128,
> > >       S390_FEAT_KM_AES_192,
> > >       S390_FEAT_KM_AES_256,
> > > +    S390_FEAT_KM_EAES_128,
> > > +    S390_FEAT_KM_EAES_192,
> > > +    S390_FEAT_KM_EAES_256,
> > 
> > I would strongly prefer PAES instead of EAES. I know the CPACF
> > function is called KM...ENCRYPTED...AES... but since we use protected
> > or PAES in any other context and never Encrypted AES I would highly
> > suggest PAES here as well. Or as an alternative expand the E to
> > S390_FEAT_KM_ENCRYPTED_AES_128 to match the CPACF naming.
> > 
> 
> Yes, I am with you. But this is not part of this patch series.
> These defines have been introduced into qemu long before this patch.
> Maybe someone could rework them but not here and now with this patch
> series.

They have been introduced with the CPU model for the hardware model
that introduced those.  Naming should not change as we would run
into the difference for the cpu feature itself:

DEF_FEAT(KM_EAES_128, "km-eaes-128", KM, 26, "KM Encrypted-AES-128")

The "km-eaes-128" indication is actually the visible/external part
of the CPU model.
