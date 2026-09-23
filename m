Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC33921D8;
	Wed, 23 Sep 2026 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143375; cv=none; b=dwB/KgZZbR6329rM9xm1gqJDk38nyr6gkn7iaaf8MEJuAyqml1t0ktRGe9Z7BpbePImSPKHdv7WPG7HMcMO/ALO6J8bDh6WozBU/qXdw4W47E69JexmxxdqkKheiY0j71bBgr63vVM8sqsazDdkeOcn83pKMUQ2mip6IXzUIxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143375; c=relaxed/simple;
	bh=/9ZsZrXt3sJ7Evh/S85SLP2t51xmVXZh/pKyUEk/xJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEmpvoZrKKaz2fyc1kJ6Q819XUEI05dQD3iYQuKKIM8fmuPQTu9Wtu13tJ8vs2rd5fRB0g/o2+Op/Y581pK/g6qHPxzPmOkTqh0mVtWkXYyE5wPsTJKR/ZKNgoFsjbqAM5QzuWKFVNl8BKUrzDG6Sd4u6m2i8MPnMWuiqI2xHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l2RMgQ57; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l2RMgQ57"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N45Utw477977;
	Wed, 23 Sep 2026 06:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FYQsvY
	G2wsnBxzzyypBwi/yEFaazst6rjiPKmTG39QY=; b=l2RMgQ57gZ2c1f7ZitPaZh
	+MrPk+lPM91a9EXxM/FyYUn9Kx0r8r00yP8NdhLY3RzgS+MSpJkZvQ8vuoeH/yP2
	AB9M0jFJxgU0q5rpHsT5dJahPb3dkAFkZ1+ubogtD0AEs9OxErpbydxYNYOr6iiq
	2qA/2JrdmXn7sZg10utHlzvzEaUOLwVXaeUIkc2DQDrMfn/XTwLKUldH5Il2edr9
	ABDGcLkkKYv20ED8cKhBkHrnfDj8r8aV/GwszkZ65iwNhMu6KU6aI5Qy4/z4EAL5
	cn7rE+EAtEDxCnnYh9g2WRB1dz/mZaowRxLbA8LB+wxvZYBmGgl85RVPoWbXyIrw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1sfsy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 06:02:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3lYOS3837505;
	Wed, 23 Sep 2026 06:02:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vn27c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 06:02:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N62dsf49086850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 06:02:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F237E20043;
	Wed, 23 Sep 2026 06:02:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93F8420040;
	Wed, 23 Sep 2026 06:02:38 +0000 (GMT)
Received: from [9.111.22.84] (unknown [9.111.22.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 06:02:38 +0000 (GMT)
Message-ID: <7a05f81f-1cd0-4ef0-a1bc-424b19f04626@linux.ibm.com>
Date: Wed, 23 Sep 2026 08:02:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] s390: More this_cpu_*() changes
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich
 <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <dc01ef2f-3ed9-4b25-ae5f-1bd317df27cb@linux.ibm.com>
 <20260922182255.26236Cc2-hca@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260922182255.26236Cc2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Oa1qwrk0hedGmGrucZJmB8_nWKusJJmx
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab36b83 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lJ8Ht4UjfrDHC3yQZS8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyMiBTYWx0ZWRfX1SX6NjbDNRuj
 z1lyrXOojs5apO29u9XtCTjnmOg7XITd05JrSo/lLJgO5HP6XH7lqkVDsNdzwPsXgCjM2/wKh5q
 guxKZ4R6O7tF2EJjWMlRGgnTX9i8QoY=
X-Proofpoint-GUID: Oa1qwrk0hedGmGrucZJmB8_nWKusJJmx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyMiBTYWx0ZWRfX0LYocv9dYVN4
 IGXMFexcotpC+lMoYOU6ZmqJgkIPnbMNvY2HmG9ltH265tpuzUXIOZZKTbmoAnPCZ41zGIOu/BM
 QLvP6XWvODUPmhvvc8U3QJAHRUlsJzvTXz5CBdVjS+mA5rqlK4SyS9M+UIWCH49cF4usl6Ecr8r
 oGqa/bXJ7UBEYVeanK9FroFnuBAhJfg/qHdbKltpZsPrmnV2hNajJVGz6ff96gdCJ+3U91Ybpm3
 zBpy++82fk3+1nN1swb6xCclZNbHhhYzvKvzErNb1SXavSjwyV82op3W82sIOzwcc0Yp/uoczkp
 OTnblBrQ9FctlNlAyqJJSmwJ9TW0IplGs+PO1V0MFsJ8m0/p35qZLXSaIr+OSEz5+hr8wrKCh9i
 B9mq1k6MIXisNg92N6TZYTsS1q5iMavcfGhaMqsF7ZS172p9N4MVXLVeaw8txf6tx9DLAwcAxzq
 otak1IcelA5UUNnrIZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230022

On 22/09/2026 20:22, Heiko Carstens wrote:
> On Tue, Sep 22, 2026 at 05:37:14PM +0200, Mete Durlu wrote:
>> On 21/09/2026 17:57, Heiko Carstens wrote:
>> [..snip..]
>>> The only non-trivial patch is the last one, which converts s390's
>>> this_cpu_*() operations to use a similar scheme like Mark Rutland
>>> provided it for arm64 [1]. This allows to simplify the irq entry and exit
>>> path, however at the cost of slightly worse code for this_cpu_*()
>>> operations.
> ...
>> Hi all,
>>
>> I did some benchmarking for this patch series.
>>
>> Used a shared LPAR with 24 CPUs (12 cores w SMT2).
>>
>> Base commit: f0100363d8c3 ("Merge tag 'xfs-fixes-7.3-rc5' of
>> gitolite.kernel.org:/pub/scm/fs/xfs/xfs-linux")
>>
>> Some of the benchmark runs show +-5% standard deviation which can
>> be attributed to s390 being a virtualized system. Each run has been
>> repeated five times to circumvent the effects of standard deviation.
>> (In the odd case where baseline has -5% and patched run has +5%
>> deviation, the comparison can show ~+10% improvements which is highly
>> misleading).
>>
>> Overall, the benchmarks do not show any real difference between baseline
>> and patched kernels;
> 
> Mete, thanks a lot for running the benchmarks!
> 
> This confirms that we can move forward including the last patch of this series.

I also gave it a spin on a zVM instance. Results are quite similar.
FWIW, here is my tested by;

Tested-by: Mete Durlu <meted@linux.ibm.com>
