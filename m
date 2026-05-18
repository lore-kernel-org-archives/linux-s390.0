Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75633F99EE;
	Mon, 18 May 2026 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105759; cv=none; b=Jv9X3sGa8zQC0qGbhZJE+SHVEJISsG0D2ZpydxOtpASmeY0BNGSXhL1Lh4xUe5KjoHoJ0CZLCklbG2AdtkTM7GBEtIwP9rYivqucqEXH7y1IKwd0JkxL9PnlFBGIKj3vkjfOn4A35szPNUHAWyrP7VnN0eko58DIW9Vt6Rz358s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105759; c=relaxed/simple;
	bh=AcsfbDeU1OToQMyeb/P7qGiSa2E9k82TXw4FrU7IoFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6PLRWpfYRbNv9xX7Glw8rJ+9E5AwDB2vAizBtzEkDcWsnx0ul/wmCxytC5Nv2UNvGEa4E8UotZ3UQrpZYzEm8fNmQSouBnItrA/1CHrPFA3i/XdjrFkYykfkOwvGHGJx4RDjRXWLy/cpXtAjH8WOhDmsNFO9bByWB0rpFQgOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l1tOX1YN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l1tOX1YN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IAP8e31410721;
	Mon, 18 May 2026 12:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FwfDbP
	gCS62hoLhasMcXlMg0kycZOaaHLXnHQILMxiY=; b=l1tOX1YNrPEH8YVr9cWSW5
	a43KhDY6TBpcpn0tgxQPlIl8Zq+yNQ7G1mvaGVsAt/YPaiqhCLlsHYozSanaPx4A
	nTfn2mMcCuR9pDZirQYGi+igMKBEbPtKAc7JTnhPfDGFmrze+d9S34l4Nk1piUKr
	EGzls29Sqy56wMdDYx0VBXTYP1p7sLj7aTCwYjyleS3XGsyQLfcSHVhTRIqJi8XV
	y9dRDizB+T8tH6Eh+ObYCVxKAMFxMYc7Hqlq9+BAvZytccPb/GK20Gniz8EcuW3O
	fyMRGIXJKCBTP0aHuGHKZPD6P3psfFPdApwVmAZDOITA67YW9i4bOv1Vzxb3Oc1Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb87cg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:00:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IBsS6Q001383;
	Mon, 18 May 2026 12:00:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vnucr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:00:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IC045Q30802350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 12:00:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C59520076;
	Mon, 18 May 2026 12:00:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0580220074;
	Mon, 18 May 2026 12:00:04 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 12:00:03 +0000 (GMT)
Message-ID: <b681c7a4-7e86-4f2d-84c4-d74c9b7fd1aa@linux.ibm.com>
Date: Mon, 18 May 2026 14:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] af_iucv: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Magnus Karlsson
 <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        James Chapman <jchapman@katalix.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        David Heidelberg
 <david+nfc@ixit.cz>,
        Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
        linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
        kernel-team@meta.com
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-2-0d8eed952627@debian.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260515-getsock_four-v2-2-0d8eed952627@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExMiBTYWx0ZWRfXxO364hcxmHy7
 ECq+ZnVaWD0Q+cndgBeXzUz1pcmq4Csu2HGr3tvCLLU2XOZ5Vcpa/CLL+UeVZOn5yy51MsfO0D/
 XrRu+NTRU/Lg6dzLSZJmpHz+BJ7h8XiLJgGxDB4bhJYDnkL3ZqNt/yZj1v1obTAPFHHTJn2rvDJ
 S2/G1GLchEAyXVg7buqTxVflow8hRZ9NussecOIXJMFJ5gL14xan4f6+hLLts3Hfm3FTFdy+jzZ
 7JZKICj181I9PCakTQYWXDG6lU6apnoRRlIfqzAQV8ijJpjlYO+maIdFO9duBT8sfZQzYQyKD70
 iq8FkkDJHjp0KzbP/z/ncuiVZozwepHc+GOcVPnGrD6unlxOcZiEvYn4DIwPOQGu5gTLNvbxzDB
 /UpliIhgn/BiOXH/SxTX5j9rYIygLki630sWafnebQG9lGPKMnXm2zhctDCp1AK+yG7v7f8fXNK
 VFjmJ4JGymbk1SZmQjQ==
X-Proofpoint-GUID: MkDTiJQWGJUKnvKYL8I1CVW44oGdCN6M
X-Proofpoint-ORIG-GUID: NPjSOBv4uX5Td3VbgCFlVWupi0kAca63
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0aff47 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=xNf9USuDAAAA:8
 a=VnNF1IyMAAAA:8 a=b_-T3gKLG4GnLt35UJQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180112



On 15.05.26 10:32, Breno Leitao wrote:
> Convert IUCV socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Acked-by: Alexandra Winter <wintera@linux.ibm.com>

