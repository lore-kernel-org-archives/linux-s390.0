Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571441C3040;
	Mon,  4 Nov 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738570; cv=none; b=CKOW9o+bBxMBDm4nCj3sJ9WP2yfd2nc7RHiFjqS8C/IBLzOVSUwPGB3zbKtJl+GFbO2N8cbUvWlLxzS/vsixUKa22xC4DCXqK+h+4nGm2hH4ZL0OECx4kTxlcgUsxYaeT+fe5ZNcAkk3TNpTmcpyo1992G2gXhEJNFxmB5nlZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738570; c=relaxed/simple;
	bh=MeTxSTs10eZNYZEPyIGLWyQ3wZgS63ReMIyo0Lq7MV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9ncczpiOPn0anVanXigYJRrvZ1Tk2b5Log2gZEXxIgrogVbLLaHsyD2dbfzTzJqigynjtHHnil3h1J1VOCB4ViQGcgbmoWgvxSD/kFTx/oPXOmLxE/7t4irEjaYTDZQUiX57eZYQbjCMihCMrbBp7qLWmvuwSokp0OIooIYDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HcFBB9LY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HcFBB9LY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GbRcG023939;
	Mon, 4 Nov 2024 16:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xh3PEm
	15GiAOSPpsSWQssLn2bdtZusvSU1tsX/2xXLg=; b=HcFBB9LY8c1iBE2TgeglKc
	SxjK5F6XXKKjexx2Sx+jGBdOk96Vei87eltpz5mYoF02g9312RWeNnLFU5lTZGIu
	D2Skg9dT6CwDA4yx98lO2sC9tpr8Cu70noP0zWtQ1jtlVOrEdYbXG48dm5GLr/dm
	fEYHEkCPntEl7EVkBnmfC+8MxJQ2GUjzefYT1mB73yWsKcMu9Tbg+1gkSEGczldB
	IepDgX6RzBEXG0d6lWbuvvr1GsOi9+NWzhEY+1EyA7kXsz/7d1iM276IK621pjIX
	eJMQ3lISmHJG7nJRCb9T2378KPeJBGchqMCO311NxRafx0cg9/KJIG3yP3cHWwqw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42q1430bbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 16:42:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A4GgZvA017739;
	Mon, 4 Nov 2024 16:42:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42q1430bbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 16:42:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GFAFP023984;
	Mon, 4 Nov 2024 16:42:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsxy34u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 16:42:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A4GgUVH30999146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 16:42:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 607A82004B;
	Mon,  4 Nov 2024 16:42:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE5F20040;
	Mon,  4 Nov 2024 16:42:29 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.20.231])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  4 Nov 2024 16:42:29 +0000 (GMT)
Date: Mon, 4 Nov 2024 17:42:15 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer
 <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Nils
 Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul
 <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: increase SMC_WR_BUF_CNT
Message-ID: <20241104174215.130784ee.pasic@linux.ibm.com>
In-Reply-To: <20241031133017.682be72b.pasic@linux.ibm.com>
References: <20241025074619.59864-1-wenjia@linux.ibm.com>
	<20241025235839.GD36583@linux.alibaba.com>
	<20241031133017.682be72b.pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KKJemEDYMel8fChJpvLQZAfhttD1aN1I
X-Proofpoint-ORIG-GUID: h_bJPmKXLraQZfF1yiYE2828jM_WmhM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040140

On Thu, 31 Oct 2024 13:30:17 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Sat, 26 Oct 2024 07:58:39 +0800
> Dust Li <dust.li@linux.alibaba.com> wrote:
> 
> > >For some reason include/linux/wait.h does not offer a top level wrapper
> > >macro for wait_event with interruptible, exclusive and timeout. I did
> > >not spend too many cycles on thinking if that is even a combination that
> > >makes sense (on the quick I don't see why not) and conversely I
> > >refrained from making an attempt to accomplish the interruptible,
> > >exclusive and timeout combo by using the abstraction-wise lower
> > >level __wait_event interface.
> > >
> > >To alleviate the tx performance bottleneck and the CPU overhead due to
> > >the spinlock contention, let us increase SMC_WR_BUF_CNT to 256.    
> > 
> > Hi,
> > 
> > Have you tested other values, such as 64? In our internal version, we
> > have used 64 for some time.  
> 
> Yes we have, but I'm not sure the data is still to be found. Let me do
> some digging.
> 

We did some digging and according to that data 64 is not likely to cut
it on the TX end for highly parallel request-response workload. But we
will measure some more these days just to be on the safe side.

> > 
> > Increasing this to 256 will require a 36K continuous physical memory
> > allocation in smc_wr_alloc_link_mem(). Based on my experience, this may
> > fail on servers that have been running for a long time and have
> > fragmented memory.  
> 
> Good point! It is possible that I did not give sufficient thought to
> this aspect.
> 

The failing allocation would lead to a fallback to TCP I believe. Which
I don't consider a catastrophic failure.

But let us put this patch on hold and see if we can come up with
something better.

Regards,
Halil

