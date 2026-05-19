Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252AB27E049
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199746; cv=none; b=fWdGg5xPY3d0OVlfSenyzWq5FgKQYTf3neGDdY9tg0hLwlGuOFnLpJOGlJ5M/YWX0Q3x9iQk72+P3oecefMA6sZmJ0tkuBkKRd/giAa0+ZGvexeUDuWTO50bzUA+JLiNo2Cg47xjeqcjozqwqv9USMqYtaL4ZHek9t2R2J1yDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199746; c=relaxed/simple;
	bh=py1MRqKn7exNdjXsmsX1yh47Z7tsmCUTS6qgb/gwScY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3ib+GGtGWogVmbCK/+q2faECS7fcsJw0PvaLon6hcqrF4LnatBRMiPaO51zVWob1eCMszrIRT9ntFh25/3OV8OeoxpUsnymKNR8RtIDkJC5+82TRTemtnrKEiOH8lreMAKEf+W4UqqXaFiMt9D98CmM0U/dPuJNGqlqKyBTZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhXwcjPm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRC8Ur9P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhXwcjPm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRC8Ur9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779199743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
	b=OhXwcjPmzthMmcuJF6NlB81UcI7ITtN820Of3A/rv0FnVNfHfIs4QiDT0X+336A+LqshCx
	/kG6EgwyZGmP/uedWYCiimK9KwVpFpl1Mz12Dr35SsJvo5kBVo88N6VAVtfq3RGsUrzfg9
	qsMxjJJ5iP/GNE2j7nhfLhu1/MoAHcE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-sRCPA9AMPVaaUk2RrOuEqg-1; Tue, 19 May 2026 10:08:44 -0400
X-MC-Unique: sRCPA9AMPVaaUk2RrOuEqg-1
X-Mimecast-MFC-AGG-ID: sRCPA9AMPVaaUk2RrOuEqg_1779199723
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fe24773c8so18812705e9.3
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779199723; x=1779804523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
        b=BRC8Ur9Pe6V8siEVZXvjQ4vQL/dOC7tOrTJVQO4KlIAJGjCSqmNKiuq0WqYYb75s9e
         5YGxcmggdQw2MnMThPhCaDTB7oAfDMafrXc83MAhMa8XvCBIW8LAJhgnVAO+UCDrIKwl
         DYfSQvQo1lZJCfOrABPbMrMmEmhxfsSKOpRodnWeK5GyYPIvGWW9VtGc//IG517niLBX
         izknrQRhMAEtj2ZmoQJNItwF1B9mbvwfBOlyT2EUPUuiWfduMnSoqDe6BIiRVFq13kJ/
         I4yrK7HeJAd8nBWD127GBSR0o+MavsTji0Lc7uWImQ8WHA8XlIUTmYZKiu4GuTqHdbMF
         8TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199723; x=1779804523;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
        b=rZWQ+W/4Q85yZuZ/xo9r4jLkcKrMc8HgIaVJka6CW7D3KfKNsMYaEHblM/kK84ag9i
         OogwHhIQzLsXo9Ye472LuoSvVAUNYNCO2RGCzfPERy1HwHD+Fr0E2tdF5vA8638EDHZN
         klNggqqW8bMGR016SaehjFVFZ20KrIsW2cbP1cYl+iaoFpQuk9s9lMGNt+HJ2VkWjW5k
         4yUzj9Ub4X0AbEVtX57GvCAfUszIBcMXcK8BnmwnhxpAsRgCqAp4QRvlnmWJjkY935cK
         Dv5nqLzUVl4r7h7wvqv1/YeZIGrZqk2L8AUTjM1954UzZAGHdpGXaHaJoL4By6pQPPA+
         42cg==
X-Forwarded-Encrypted: i=1; AFNElJ8Nza7OpokhAFq1WkE+YzvGg7q4nB7R+zL4o0EkKpudBrpxoAoBeyE1aqI8LYA0DdmBSn35rxpXJnzT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkk6WUo4od+9pwtjVzrI7seYDL25SV0vaq0yGILd67IqxPi0Kd
	+2KMfgT+v4mJiTEEEFldsszNrkZTcWP+yT6HB9Y0q2adr8/MLNqv6uW8Lid9jez7vmwLfpRc2/w
	+JuI9J7lDXwJFpoass7hegyxZclk9KCiZWPc9b94fJ3Gma3dunqh5UKgAQUagRSc=
X-Gm-Gg: Acq92OGKttFS3+n3LT9EC7Atf8ZF5bS6BBaw1PExEfnuf+9vDVblLPfyZDktwII31h2
	DYi19uvRenfR9lSEtK6YPxsoQd/IM63KrOxB8/cihyq+dbhHTkvun29O9fxPrQUOjmOr74QNU7Y
	XeqtPjpmjO9LCLV1w1S6Qr7GnYmEAvzG5YE4sx28y4NlsB63eYgALX3lfexBMExvK0E+hluOb1g
	NaOvaR5vaL2jQPkbVTS8BJsHZ4mMtCHtXGHZ6iQwZgZRQTUjVCvhKcdZnAiORTUqO9jtIQ0O4V2
	RnR05YUTEn2pSWKgGMqjyj10rlijPztUhrHFxJU3zNhJHRDPTN6N/H8bsxblHfgL0okHq6BsQeR
	9rwdhspd+MfJi5XHUBFezb4RRkjjkgXz3P7M1+ricooxi/YmFTZjR8yXZiXAWMA4raw==
X-Received: by 2002:a05:600c:5304:b0:490:17da:27f8 with SMTP id 5b1f17b1804b1-49017da2830mr97673415e9.18.1779199722780;
        Tue, 19 May 2026 07:08:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5304:b0:490:17da:27f8 with SMTP id 5b1f17b1804b1-49017da2830mr97672985e9.18.1779199722357;
        Tue, 19 May 2026 07:08:42 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm204874615e9.4.2026.05.19.07.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:08:41 -0700 (PDT)
Message-ID: <c05304bd-1c7a-486a-9929-e6947de07adb@redhat.com>
Date: Tue, 19 May 2026 16:08:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] tipc: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, David Heidelberg
 <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
 kernel-team@meta.com
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-7-0d8eed952627@debian.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260515-getsock_four-v2-7-0d8eed952627@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 10:32 AM, Breno Leitao wrote:
> @@ -3260,7 +3260,6 @@ static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
>  		break;
>  	case TIPC_CONN_TIMEOUT:
>  		value = tsk->conn_timeout;
> -		/* no need to set "res", since already 0 at this point */

Since you have to repost, there is another obsoleted comment referring
to "res" later on:

		return res;	/* "get" failed */

please strip it, too.

/P

