Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812444;
	b=4uVmwnuu44hSmd0u4NsDH7j9acKSvL2mJnGpIAzWe01H5RfpeQcSe3cpiyp//KTXBnm8
	 kNtkvrwDoH9s7fgIYoyWb/l/W8bsFHVszLKOajM5XHVRrxZUSXbRFfvBf1+02NyyyhEGJ
	 VwEH38NgoJkFb9ugHqkyG9zQCAJG6f+4ufVWDhsGo0FD2gV7hi3J/A2uBecN13PBqylmv
	 QZ/0HCI9HwiuRFzEtiIpMob0I3CKS46ps1Se4vWv3PlZgIBf9Swb1K2bke43P0C8ak2uT
	 TIVUlnEZBiOc62Ca7eldK52rkLOStHLgTxinSKz9/e5cqOrhZ5/Os+Px6Ws3lc8+4AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812444;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+oa80km94hmaMeq/3OIriRDTZZb4ODl9Ey/VzJCTaIE=;
	b=o+1WgeFDs23Aj2KQA0IbfomqsroTcdcmIz6dM8HqxAgm8efrr3PABcLF/tR4O/kq4DMd
	 sHtmkcHRPyHMTYqaf06CZut43J3ATzb3jabCqxmcxgjEhaNL/kg04IcgV0ESFCDGXGe4h
	 Uuc9K9qKbkTwkWxynFmgVJSLf1Uc9e5uTQcYkyCFeBjva4sBiXA0IauH3JnKJVILmfiLZ
	 AF8m/pOeWBth/VxFZDFQ6iQxaoYXpUgWkiDS2he2yGCDeWm6/ROH+iKaQtlEFaNk1iFjF
	 LmQAFFaDSyeSvDB7UA6ppMNgCqRpAOAIhpW2Ljx2mYFHhkNnLJDksKR34iwteBAZWmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qkknJySG;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52341606A326;
	Wed,  4 Nov 2026 17:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52341606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qkknJySG
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Fi2TX959075;
	Wed, 4 Nov 2026 17:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+oa80k
	m94hmaMeq/3OIriRDTZZb4ODl9Ey/VzJCTaIE=; b=qkknJySG/0ltIHzczrI5cM
	d76ZlbL6GdOHAvrjl8TFsWZoU/5SBDOlzF7QNPxvxcSTYyYJcw/QXn9mwptXF8wh
	+ssMFRbvNEzatoLvC5PuCVaAOCJkD0gkQ7Ucg5KUGAzgNaaa7+r+w5Det43I4QTb
	Ycja1Ct0zrnfEy3kOpCVTvK4At/HSHm0nHDlYcwS1X8bIhXSu3EKVzEP+/FDThJR
	mcVDyKQkmThgn8ZhdAHcb4k9Era0LHrPq6/hN87CAjuWIKq+IC+nHJp4CTZl8HPr
	uLJkhYxynhS3FRYgcA8t2L8bzvCohwgwJtAKCz5sTIXE5/7QOBPa+axe5ZO/m/Ow
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826w6mb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 17:13:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FnxmJ204445;
	Wed, 4 Nov 2026 17:13:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqf0gen63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 17:13:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4HDnKZ52035964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 17:13:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEFE32005A;
	Wed,  4 Nov 2026 17:13:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C43202004B;
	Wed,  4 Nov 2026 17:13:48 +0000 (GMT)
Received: from [9.68.29.38] (unknown [9.68.29.38])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 17:13:48 +0000 (GMT)
Message-ID: <0551c1e6-f456-42d1-b3ea-ce22fd9bd5ee@linux.ibm.com>
Date: Wed, 4 Nov 2026 18:13:48 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net/iucv: do not count the SHT frame against
 the receive window
To: hexlabsecurity@proton.me, Thorsten Winkler <twinkler@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Hidayath Khan <hidayath@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd@proton.me>
 <20261028-b4-disp-dd3e4ebb-v2-2-3747658d59bd@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20261028-b4-disp-dd3e4ebb-v2-2-3747658d59bd@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MbLNqIDSx1KRLp7c3dLDbLtkC7omfo3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2OCBTYWx0ZWRfXyeqbxfpWA1mY
 YWCKxJcuR6RsS/c5PgZdRXVayoFBIr/TCaUKjznxLp6bYRXs/Hw+c3LaIT4LCxzCOV9z9mFbLmA
 I+1vy3fjpbGyd257s+Vr9Q2ZbqCR2RtQnuLSZzbMJHp1pugH0PClsgH1fuoZQvNzbv5wwKd18fm
 EXUOiMNRjb4tkUsMrxJc2u2oHwmtAn9TRLQwkmV68uIx8XTr5Cu3cRnBIFxfGb794PcOqVoHO3d
 RufX/2BXSYrblMA9PBtwpetSu+bwH9HVYVnKDALBJMmGg9EdP1FJPUZ5YsusILmD3w2+e4ToNBD
 ZdLyUB34lXaNYUZ1IkEsk5Tcf4iim+3MAaSdZAh/xfGterO9niof7PxLxHJ759V/Ek+BO94Kkr0
 ysprhcIRc3UgI251fOGApeMoRnBZE9C5eDM6enISoyGVv1HsKSIHW/t1Wy+lyLVHqrzPmXdf7GV
 TQEBsK/7yhTmMWHGkJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2OCBTYWx0ZWRfX8Du7jndDImgJ
 ysrR862IiCfIPAr9+j6WsbHLngtU+no7kbfFHrMlq/amJHuPgMB0gtslievO05l0Cg7UCTJ6DVa
 zgs71mhrrzxUyOzLfw86+1FuS6qvYpA=
X-Proofpoint-GUID: MbLNqIDSx1KRLp7c3dLDbLtkC7omfo3e
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aeb67d1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=mUOIDo_B9oOLisAdC-oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040068



On 29.10.26 05:46, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> iucv_sock_recvmsg() counts every HiperSockets frame it consumes in
> msg_recv, the SHT's empty one included, while the peer counts only what
> sendmsg() sends against the window it was granted; the SHT goes out
> through iucv_send_ctrl() uncounted, one per shutdown(SHUT_WR) call. The
> next window update zeroes msg_recv and takes the surplus with it, but
> recvmsg() sends none while frames wait in backlog_skb_q, and an SHT read
> in that state pushes msg_recv past msglimit: WARN_ON(1) fires, the socket
> is closed and the reader gets -EFAULT instead of EOF. A peer that sends
> past its window reaches the same WARN from the network; with
> panic_on_warn that is a remote panic. The SHT frame dates from
> 82492a355fac, the WARN and the close from 800c5eb7b5eb.

I agree with the ananlysis, at least the WARN_ON needs to go away.
I will try to reproduce it.


> 
> The SHT reaches recvmsg() as a zero-length frame, like a zero-length
> data frame, so test the length: count only frames that still carry
> data when the read consumes them (rlen; a partial SOCK_STREAM read
> requeues above this point, so each data frame counts once), and close a
> socket over the window without the WARN; -EFAULT is kept and nothing is
> logged. 

I understand that after this patch this path can only be reached /
reproduced by a modified sender?

A zero-length data frame that reaches recvmsg() sets
> RCV_SHUTDOWN, after which afiucv_hs_callback_rx() drops every later
> data frame uncounted; the one slot this patch no longer credits for it
> is lost like the slots of the frames dropped after it.
> 
> The close over the window purges backlog_skb_q, not sk_receive_queue,
> and nothing resets msg_recv; once empty frames are not counted, a read
> of an empty frame from that queue after the close would skip the
> -EFAULT branch and reach the window update, where iucv_send_ctrl()
> sizes the skb through the cleared hs_dev. Send the update only while
> the socket is connected.

Shouldn't the 'HiperSockets receive path with the socket lock'
prevent this?

[...]
>  			}
> @@ -1357,7 +1360,11 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		}
>  		spin_unlock_bh(&iucv->message_q.lock);
>  
> -		if (send_win) {
> +		/* iucv_sock_close() clears hs_dev but leaves sk_receive_queue
> +		 * readable: a frame read after the over-window close must not
> +		 * send a window update.
> +		 */
> +		if (send_win && sk->sk_state == IUCV_CONNECTED) {

without the socket lock, this can be false the next cycle, right?

>  			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
>  			if (err) {
>  				sk->sk_state = IUCV_DISCONN;
> 

