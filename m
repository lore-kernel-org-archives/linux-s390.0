Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B63932E9;
	Thu,  2 Apr 2026 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775166242; cv=none; b=Dx8FxnI2YcbdYhUuX3hVn/1zpxDanSA+msnJ8NdH16HWcWlYaHgtxMpdQ6JB1J9qG8GtAhgqz3+6SCUmSqR48I1aKcOgGMrZlmzaMtzuVPBfDPDuE7j4gfRlXeIdgp66JqFdOBoHRptTs6fr/U9gbX0I3gtFIp5LIpPuXPRzZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775166242; c=relaxed/simple;
	bh=SI0BhKk4l8ktdNPcQCMrH51z0+Ccx5A1FDS0/1r6EyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adHeqVkMd/SS2JcQvzeQud6iaUlhieWkOOSlBRE0RWJQVyBIZTYPXVfTK/PijyZuPc8rdQf3obigDdL0IRU+c+OdCQSaNwDYgRofcmV22Z24T5i0LBRAmKwSyVTdurhhTeuJjWdBrdUznk7ARIjrwSIC7jxlmRlZuDsN5L6cAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EP2Z25kk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EP2Z25kk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632ETO6E150841;
	Thu, 2 Apr 2026 21:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=goxDc5
	aHiWikJErNAbMluSbuAXjflIM7oz8eIysKQcM=; b=EP2Z25kkbRk1eO6WPYkhfB
	AchsNRQGzKnj9AnMP1m/J+1i6wBk7XFwCBihkSG2+Xbwr6uHSb00QfnXQPdv4NrR
	iMro1IJ808QXvWgnq+XexXrDdqhkpvuVXaQ4xmZOW7kuoaNidbtTs+pwAYWeXH6Y
	Ng06WV/nwsqTdzBJ1ohUuE6WLfqB7iD/qfnCs/vLVMr5CwxUQ4Sh9ydSV6IJ3MYu
	Sh6XwJdz8k/MzBI+qfdY5ziqXAENcYXoj4m7V0jiw9b3ahlhhJ8bUpefNFgCb19r
	olcbstcaDjuj3QVwSOZ3bURihj7SuFGdZcQIN3cP3keHnvSa0H6LXE8OwRKiLYcw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgwxbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 21:43:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632KPnEj022165;
	Thu, 2 Apr 2026 21:43:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanbt64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 21:43:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632LhusA8389244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 21:43:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22A3958059;
	Thu,  2 Apr 2026 21:43:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FCCB58043;
	Thu,  2 Apr 2026 21:43:54 +0000 (GMT)
Received: from [9.61.131.108] (unknown [9.61.131.108])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 21:43:54 +0000 (GMT)
Message-ID: <2ae923d5-54bb-4f7f-9389-f095388973fa@linux.ibm.com>
Date: Thu, 2 Apr 2026 17:43:53 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] docs: s390/pci: Improve and update PCI
 documentation
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com>
 <20260402-uid_slot-v6-1-d5ea0a14ddb9@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260402-uid_slot-v6-1-d5ea0a14ddb9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE5MCBTYWx0ZWRfX7lYfWstE1uqj
 ljaMuXjr39j5W0lN1AZPJDGawq4ZsWco9XvPCFhTSxKnyC7vNC+jpinqMCQLJZphGZs7GeTXxUI
 j11AT4//uyUH9vB67VGPkK0fl1cGG+5jh2Y20ofUrEkzLIjqtLWPc7byP69bfuHCjpJrtTSiWkM
 GEc3OnY71Z2S0KVAJ6ie/25mXZtJwny6iufue7xWyeTKcLKIeGJ4WuwV9F/fA4AbYEs7k2R+tQG
 AGkiSdD7DpJ3KbdSbdjs1PltM0nVTYVp0TfosakdJjTK9mOl8JjOr70wTZ+y+Itu95/8bXwD9fE
 JQO3imz6b6QuK1iy6L+y5PTg7sy7HBysneP5BhzpsJMf42esCDe/IojJ8sTr/7sv8DuLKs8sAqF
 vQw+JVk1Lyb8azAzpKF0pRQnjUwijYammEledVL0hJAOLnZPwKJAWACF6Qzmp37eC3iSdpq2wA+
 pSS1ltcmWfe73qUYPQg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cee31e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=oRystrt0tCF-gDNIJG4A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: k3POUQ-anM88a3MZDSVAWxi4Dqo8zdr2
X-Proofpoint-ORIG-GUID: 3Q-qSvtcNGJWUnhHqxWjZ4pPH5lNZX0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020190

On 4/2/26 4:34 PM, Niklas Schnelle wrote:
> Update the s390 specific PCI documentation to better reflect current
> behavior and terms such as the handling of Isolated VFs via commit
> 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs").
> 
> Add a descriptions for /sys/firmware/clp/uid_is_unique which was added
> in commit b043a81ce3ee ("s390/pci: Expose firmware provided UID Checking
> state in sysfs") but missed documentation.
> 
> Similarly add documentation for the fidparm attribute added by commit
> 99ad39306a62 ("s390/pci: Expose FIDPARM attribute in sysfs") and
> add a list of pft values and their names.
> 
> Finally improve formatting of the different attribute descriptions by
> adding a separating colon.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Definitely an improvement.  Thanks!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


