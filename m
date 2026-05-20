Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB913B7AE;
	Wed, 20 May 2026 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285064; cv=none; b=A6iRkQQINub1+aA9ymF6n5gJFxlftzTjLmM6Hohie0+pgJjJ4z68+ZK5yPbvzo59x/CBMVo/05ZyQT3vR/7yG284CcnZps1f3K50WLicMf8hwv+yJaI2k9oULb5nx5he37xVCUXZ94uJfCZMycXGz7Af+Q9hFTXCAI5peZj4MC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285064; c=relaxed/simple;
	bh=Tf46coZTLIsBA5n+/BSZv3dM4OcAeIn6MyP5LzEJXYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9tpzcqFJ82t4dPaK/2IPCmMRU0Q47bzebd4zzyMeVSCEV8MDNIa8mRdUEoz76UVybrvvsAKhZXZCC5T8VH8/xHrc7AFzVvFIHMy0fBS9PIVNzTAr9KB+hBUxFSd6tae+oZWbS+Lzk62QMM5o8OXiM5npFg22jAaK4NO+DNlI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EoD5iaKs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EoD5iaKs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDW4253601206;
	Wed, 20 May 2026 13:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4LuzPVdymJnQ7OZiv5vbwQnrnB7z0/
	n1JcSAIORjZBI=; b=EoD5iaKsNlBXkZz/SH0A+G+ZiGurAwZZKYzM4w4kbrRLw+
	Dt48tB8XNv3xHU64nvJvGhIG46j4VVNJFfdPNR2NB+pQzE8Y8KS6Dinksi2PJKUB
	JlIDDFBdG/5eGqxcpShva6ei3GAGfotG7ucxkG+rJUomzjfOC/+T9zIss07p0T7g
	gutW8/NzcWMTynH536Bfy9c6ROMAIn+2b0r9KMB3gyKbHSc17Z7AZb2dR2B9bgEN
	3YWJbtWV6kEJnGN0skkwUCC40nuVRYwaXd/Xbg7NqafjKjjzdTKKNsAL+nrkUq/f
	EPP9N8FInUJ+8cTMNvzBsVrua69Wuua4Q7drqFZA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mt9hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 13:50:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KDd4YH000521;
	Wed, 20 May 2026 13:50:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk7k7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 13:50:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KDomgG49873328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 13:50:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE2B2004B;
	Wed, 20 May 2026 13:50:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E30DA20043;
	Wed, 20 May 2026 13:50:47 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 May 2026 13:50:47 +0000 (GMT)
Date: Wed, 20 May 2026 15:50:45 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 1/9] s390/alternatives: Add new ALT_TYPE_PERCPU type
Message-ID: <20260520135045.96889G76-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
 <20260520092243.264847-2-hca@linux.ibm.com>
 <20260520134317.778dc094@pumpkin>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520134317.778dc094@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 95UgnGL4owA0HGVAWRkxIzL6YcAq5Fp0
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0dbc3d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=-J3efravqDvamtWKT7kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4eKmeADhQ1Jn6yIRD49QC-YLYUukZD6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzMiBTYWx0ZWRfX1aFGCWfl0EdW
 hMvmUEsQOKBiLBKp4uGuAedh8CMQwyeM0TQE1nPOMLCGuJQX5sxz7LYeGFaRv+fp7fStbsUYZDo
 G1QSmndsnq1G1CMvalEjCAfOQznMr8LtUd3M9uX3LoOjrAQWORYlKePHiMFlEpWF9/2EwilnLfF
 ujZR2qJmoXYpnE/xRRHZk52JfctJpljYzFCU7G9MN0g9MCIB3JxWLcsuEusWuN0/d+2L83z9ola
 MqxrCdadRL+g2efcgjS7IYnrRf7hKHuCg5yKnznKAlv0U+wQVVdyudWwONNWnHbmea8ab96ejbZ
 8GQrEbkMtCJ/TcgDa435/jE4+YNHegxCKDhMqyA/La+eR2ZgS2Xq/emD6/Ju3e82QKdwvHAPFtt
 ZOa7ykDt2LwfE+Ob14KOXePT58hZCmqMfZ1zi/Ik+wDJwIXcFe1phqxKJBbaVxAjEi1vQYfPRsN
 qxbL/oP1XD3LJC5as6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200132

On Wed, May 20, 2026 at 01:43:17PM +0100, David Laight wrote:
> On Wed, 20 May 2026 11:22:35 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > The upcoming percpu section code uses two mviy instructions to guard the
> > beginning and end of a percpu code section.
> > 
> > The first mviy instruction writes the register number, which contains the
> > percpu address to lowcore. This indicates both the beginning of a percpu
> > code section and which register contains the percpu address.
> > 
> > During compile time the mviy instruction is generated in a way that its
> > base register contains the percpu register, and the immediate field is
> > zero. This needs to be patched so that the base register is zero, and the
> > immediate field contains the register number. For example
> > 
> >   101424:       eb 00 23 c0 00 52       mviy    960(%r2),0
> > 
> > needs to be patched to
> > 
> >   101424:       eb 20 03 c0 00 52       mviy    960(%r0),2
> 
> I'm sure it is possible get the preprocessor to extract the register number
> for you.
> The exception table logic almost certainly already does it.
> (The x86 version certainly does - and that is far less trivial.)

That's true, the s390 extable logic is doing the same. However I failed to
feed the extracted register number as constant into the same inline assembly
it was extracted from.
