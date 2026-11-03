Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715523;
	b=kefI1XGsIfw6y2Fh/HGWxMHt9stjhPDlAzbdR02Eb3KVFeUMnHcLQZ9q6AImsUQo7A+K
	 azD3K7g9YwARJoddLoziWPx+kIWwmwq+BcwWWdO0VkN9SRQy5s7Dzq3lhoG8OXJgycmaA
	 NDFl8WYYpWyKc5HEwSYA+SCwNkg36LaxHDTBYnimK/ks0hutBK1QkIcoOQoHvTHLvfVp3
	 VDX+oSrfY1g/udfMl9/tqZL1te7HQzkOsI/4L9sNAJk9D/GbTMpByTUDn9cnF6H/YUNsk
	 MVxWmm+lCHTfxFpp90/gTOz8mrSJGVogO1z9Two132c5GnLQipYUW5nn2ciP+PeBa5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715523;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=87L8NH0chbxJMXxlwkxaucZepbhcei/lYwpnUvY2jS4=;
	b=tilMCQaHZGZK5v3fYcb0180kaMklnQQT186pB9fYGQkr2zxq+SiBaJktPWEw8FJlz/tL
	 g8QR6p0SK4HN7SS1uUXbCQ2oBlOhZWdBsZxWZU6xsZbzLIsyQNHUfH6hys7oD10Gn687L
	 /PfYsyH5UNx1OvDNSVx9YqWMEKMpyh6w8MVa2kIhJe49LaQhSaZ6RkBNQs1/N3L7r4LAC
	 IiQhtStCGwC097pictJP6QZxnDUtCFOWzKnCUB9IBTeZJC4s+ZlqEfAXFL4aZWkXH4KEc
	 dHXONhIVr9BtzvAGJJqpe/FKjRld8Kn9Qd8QC/OS0deLIQajwKok6kf5LEC5IM9vEsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d2VuZdJs;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UgDLLBfc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D023606A336
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 14:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D023606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d2VuZdJs;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UgDLLBfc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793715522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87L8NH0chbxJMXxlwkxaucZepbhcei/lYwpnUvY2jS4=;
	b=d2VuZdJsG9PeUOo4SXfGhpBqTNlnJEubVtaF3lW2dbZqAHJseun0u4wZwx4ukzgutJx1SB
	jU3NNjlFZuM+472LdQIQKQXnLrEhj6u0Gmwo0tGfeZ/PYiBONKJ61GUJyhurAWL4M3gUZL
	e5SQtWvN90dpmb7RVQ13blBG36lrJdI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-NXbOa343NuOf9B7eP4d3rQ-1; Tue, 03 Nov 2026 09:18:39 -0500
X-MC-Unique: NXbOa343NuOf9B7eP4d3rQ-1
X-Mimecast-MFC-AGG-ID: NXbOa343NuOf9B7eP4d3rQ_1793715519
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e29c25101so2280821f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2026 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793715519; x=1794320319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87L8NH0chbxJMXxlwkxaucZepbhcei/lYwpnUvY2jS4=;
        b=UgDLLBfc/bXJiOyeTY9h3E/2b9NcVvDXC2LHhKd1RL9yvya9KWHlPTuzXFDRw/ZYkI
         SyMPuW8h+ac1OXG31eFAmG8xUx4mrLWdqwU8VefOMWepj8xXAmYr50zgPseM24oVZBGf
         pVQwm2sgTBDxEbvuBBhORrgapJVaQMcBDxU8ILnrhmQNpHDzS9eiJOk4sX4J2gkAAuRD
         4ChNUmaElJnviB+3xvHvIp/S9vPdcGqNS19YHNj28eFbYlShAQ5dLnkz+44TX2vn1ovf
         nUPmyUsZjhbGga0wb0SxvRgRLABPX0orDHe1hm+r1Wbx9w+eU97m0oY43FVB85m4IP9Z
         17gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715519; x=1794320319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87L8NH0chbxJMXxlwkxaucZepbhcei/lYwpnUvY2jS4=;
        b=UWxvb8HolKSS8+G0wpxgl6nNYniRMXO5Uv/YLmVl38laxnF3aVbFVeG96R5ZWtbT67
         5SOq3Di/V5EA8R+KjAxtw6FKLhwRHMP6IJaJqN150LAkbZDSTBa9Pk1wIO6vIXyGZfQR
         /2Byv7+/ecI8RQZnQAFCx6mCxzffFkJtMHhecVO7j+fzcyhg3NnPpHiiytdgxmiJqvIM
         UKeSF2b4AuGFVyWXQR2KQFFLXKVH8dNsptMsZsvV21dyyLMmTc/+U7LJgNpejWf8KVV2
         6CQON6j9NEdHTl74/fxA6/Wj/CnDnidTSObwdf5FSAIqgatc6He9nfXX3VD2a0RIfpFl
         KDog==
X-Gm-Message-State: APuU4Z9pSA1qNewFLhPNzEAJRm9vrNrPHPJ5DcBpElnPbHdb6hDCXp1a
	g7XoMsXFzeb71Tlq+xkuNXMIdRtgD6QxCmkR7Kd+niC+jt3zvOPBMpy/YHFNyZ+nc1AciwFknIC
	U4e7w9ZoX5BR/F2mocP3RLqqZAjZm90uDxCXx6ER8rSGcrpWhQ/WdB3w/T5hlsTQ=
X-Gm-Gg: AYBFou36MD/hbnxcN7ix98Uykj9rrNuuiur+ean5FweMAxmgOzjI72X9w2jZrDnc2Vk
	DxX00/yqDlvXR8lEU3ivw1LvcqBt7EO6a+zi+/Uin4T6/v69FQe52H3jME8sfLRsRL5zVNDF4nw
	NenimvC6aNpbOdkds8yMwkQLmMi5GpajE9zmjM9WeVq05Jr+dNHBdMgNLVBS4X+/jR9G5VDST/g
	akB2H7r9Bal4SbXDbyAK7vfcrE3EjiHoaZL31IM06qfIx37Q8r4lCxnRVDRVn6cqipWkRKxmIVw
	fs4N4ZxdC16+lIYd17KNGQUUT1dJi2VPmj1bINyWZ7GF9tJS8jnZJE50GTkstBhjRqrV+9uZBP2
	4fnzsiX4mPXh39ZNomZv8l33iJvwlpY/YqNbUt2F6sJUrOCckw1Wkf8GhdMshdQU7FTWkV7q7p7
	cpgqH0J7YjH6rHvSKzs0Ux/LksgAOa5oG+qAZ28mp4lP8=
X-Received: by 2002:a05:600d:c:b0:4af:83ad:8f70 with SMTP id 5b1f17b1804b1-4af83ad8fa7mr160826645e9.35.1793715518723;
        Tue, 03 Nov 2026 06:18:38 -0800 (PST)
X-Received: by 2002:a05:600d:c:b0:4af:83ad:8f70 with SMTP id 5b1f17b1804b1-4af83ad8fa7mr160826195e9.35.1793715518348;
        Tue, 03 Nov 2026 06:18:38 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab3ea6a9sm91268795e9.15.2026.11.03.06.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 06:18:37 -0800 (PST)
Message-ID: <4d97a782-8d88-4dd0-b819-fb704582f2ec@redhat.com>
Date: Tue, 3 Nov 2026 15:18:36 +0100
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
Subject: Re: [PATCH net v2] net/smc: don't spin in smc_rx_recvmsg() while a
 pipe holds spliced data
To: Bryam Vargas <hexlabsecurity@proton.me>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-s390@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, netdev@vger.kernel.org,
 Stefan Raspl <raspl@linux.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>,
 Simon Horman <horms@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>,
 linux-kernel@vger.kernel.org
References: <20261029-b4-disp-da7f8e6a-v2-1-9052904adf72@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261029-b4-disp-da7f8e6a-v2-1-9052904adf72@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 09:03, Bryam Vargas wrote:
> While bytes spliced off the RMB are still in a pipe, recvmsg() waits
> for the pipe to release them before it copies the data behind them.
> The path to that wait skips the timeout and signal checks, and
> smc_rx_wait() returns at once on RCV_SHUTDOWN. With a signal pending,
> after SHUT_RD, or once the peer closes or shuts down writing,
> recvmsg() spins on a CPU until the pipe is drained, and SIGKILL cannot
> stop it. MSG_DONTWAIT and an expired SO_RCVTIMEO wait there too
> instead of returning -EAGAIN.
> 
> Check the timeout and signals before that wait, and end it when the
> pipe releases the data or the connection is killed, not on RCV_SHUTDOWN.
> A zero-length read returns 0 without waiting for the pipe; a
> non-blocking one returns -EAGAIN while poll() still reports the socket
> readable (splice() can still take those bytes).

@SMC experts, please review. IMHO the above trade-off sounds like a better
solution is needed.

/P

