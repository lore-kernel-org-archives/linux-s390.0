Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351374A841C;
	Thu,  3 Sep 2026 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440964; cv=none; b=TKg2KsJuakYDBBGwVovSB2fI5hOLxT4tynUfuVfA+8NPrB/HLfP7ZWPpVjrZaBcOkZy4W+A/Fww17OBdK20mrmZV5S+9cz5d+vMc25RTIYYSqSlZzZMC0fdRN2fZcRwFq+S04HfbwtH6V0s3ESkOMEbuuCmBIgGRBwPZUK/7zAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440964; c=relaxed/simple;
	bh=y0WeSMNmvquEtmZVbb1RvEBpBOgEwtX1AAkYqYEEltU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8dot7v/s0d4O7w+lmoxO+qtXrHpZNjVJ4a5N9vHbIVBx8nUQxwm4F1mJxhqbpy7xACAmXd/i5OcJxIEiph2mLaDCcfoOEHLSlLq5JxnEtZ22EP42kLcpFrun3NxctF+CsDuEV1qz2VDC3Og+MLcZgwek+LsnsERtqIEcnyaeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mRvAWCzr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mRvAWCzr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVeBB1606233;
	Thu, 3 Sep 2026 13:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T/jc++
	tLbSNEV7AK19qKe3n3s2kGYWtmrMjM1OeDxiY=; b=mRvAWCzrQLAh18x7/tXZdp
	OFAxEWgR7PVgJ0IR9yvF+XpqSFJ3m3p3uWdi10JSyi5lTIFQEBUHHp+fLbPRJKmS
	8k/zSPUwevBKM/KbD3F76vmIxmBJwSb/oJqQUPif+XaqKPu1UWWyzXAWg08IYsnu
	ECat5FPxV7rdV81Xpj0X7R/aqoLGHJcosctRFh69kwJvp4d6ONwyUIty+Vk6Vxkq
	vMsNEU/Pr3EHxC/mirkKWwi98DUWOY73USXnXIplcBi4kGv0BHBFGnebvRb6R+KF
	iyZFYHxSf7FOPy/9dzZtysaLWqqtYb7/z36jN9k78qVgOdmEKonxTBZuO2zjImGQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue4kb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 13:09:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683CuHfn024949;
	Thu, 3 Sep 2026 13:09:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hqptw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 13:09:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683D8uKf50332152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 13:08:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD49C2004B;
	Thu,  3 Sep 2026 13:08:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81C5B20040;
	Thu,  3 Sep 2026 13:08:55 +0000 (GMT)
Received: from p-imbrenda (unknown [9.87.146.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  3 Sep 2026 13:08:55 +0000 (GMT)
Date: Thu, 3 Sep 2026 15:08:52 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: s390: replace page allocator calls with
 kzalloc()
Message-ID: <20260903150852.518d6cdc@p-imbrenda>
In-Reply-To: <apkqHLgg7nqBiYW7@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
	<20260902130612.41500808@p-imbrenda>
	<apghz4XAgv0ro15t@kernel.org>
	<20260902165315.06996af6@p-imbrenda>
	<apkqHLgg7nqBiYW7@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rQsTroj8xn3GdbO75jzE15PR6kvzF6jW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfXxC/CioTB8XFW
 bXzXT7CVmLTowOI5tl6/4yAw6jKpBBQpmlAb4Q7P5G5PXe39cUj1QomSXEtIbf5l9l6bQ6vP6Ls
 oEvhWUvILExAAMl0sQqMY4Cw2qZPlQk/B6mc4BFdOD3dkf8fY+7EVHO2uDYN3xsJHuBpbm+Ykjh
 TgKMx2JGDniBOu7MpN/QBKrgW0b/OAZM73SiKTCzZeKQGV0hYIGESWecFgWrmxF80sPpNyhmdUo
 SRadS7r3Dtp0pkYfJCRDmmsEm7XrwyUAX0TCsh7B6CcQkBYLJ6YJEUsKjcKNHq94zudpCKhbdby
 bBeJT3eo9HSyC1ohspEtfzc0kQsg8M2N5LGsJz3u8ksgJhjfjdDb+JhnoylQmabsOOCrUyqOYua
 i2+eF65Qoaw5p28bRQMOV1GcI+dNKq8C5sz2leviV+LaqUQ/vjqo+aOcVOD+gZ+0xq/492z7GVn
 ID6mzmVBfT5KQ9KY2QA==
X-Proofpoint-ORIG-GUID: rQsTroj8xn3GdbO75jzE15PR6kvzF6jW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfXyG1RdVQm6qAZ
 GadFcA8vNVNNkirzwOcjbz+I5ItvsGbt/IRMHTgQU/nTsee4yZ3pdL4uury0bGiwMOzT34WmHw8
 ZKP0t+AuWlpk155FQmOuf2jFWLSs/Kg=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a99716d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=ohm-7uY5D15YhrtMo_UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030113

On Thu, 3 Sep 2026 11:04:44 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> Hi Claudio,
> 
> On Wed, Sep 02, 2026 at 04:53:15PM +0200, Claudio Imbrenda wrote:
> > On Wed, 2 Sep 2026 16:17:03 +0300
> > Mike Rapoport <rppt@kernel.org> wrote:
> >   
> > > On Wed, Sep 02, 2026 at 01:06:12PM +0200, Claudio Imbrenda wrote:  
> > > > On Wed, 02 Sep 2026 09:15:12 +0300
> > > > "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:
> > > >     
> > > > > This is a (small) part of larger work of replacing page allocator calls
> > > > > with kmalloc.  
> > > > 
> > > > I have some objections to this series, but not because of what you are
> > > > trying to do (which is actually nice).
> > > > 
> > > > I understand that you probably wanted to touch as little code as
> > > > possible,    
> > > 
> > > Yep :)
> > >   
> > > > but now since you're rewriting the allocations to use
> > > > kmalloc.... I'd like them to be converted to use the __free(kvmalloc)    
> > > 
> > > You mean __free(kfree)? Sure, I can look into it.  
> > 
> > yep :)  
> 
> Well, I looked :) 
> 
> The only place where __free(kfree) is completely safe is handle_sthyi().
> 
> In all the other functions using __free(kfree) creates a mix of of goto
> and cleanup helpers and cleanup docs advise against mixing them:
> 
> https://docs.kernel.org/core-api/cleanup.html
> 
> The cleanup paths are quite involved in these functions so using

it looked trivial when I gave it a cursory glance, hence the reason of
my original request, but... 

> __free(kfree) there is really not trivial.

... yeah, it's actually not trivial at all.


maybe refactor the first patch, and leave the rest as it is :)

