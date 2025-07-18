Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627571F91C8
	for <linux-s390@vger.kernel.org>; Fri, 18 Jul 2025 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872097; cv=none; b=AaZxVSHcb+kaCq+5ttdD0sTm/D94ekcAv9ObgQxUL2AnfzVyFUimWf5uwtQXdFupMB5ygHkBw4TJtBXDS5NAOqES+LS9GVqGFtMGvQv+mVaDoeECSDyNZ3M/aKftodU+kCRM6ZfDIrbcmtX0TF4lCF4yZB3hG0d13nMHboJbdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872097; c=relaxed/simple;
	bh=/v9WWF6F6utjgz9JGBDPXJxOIe4C/8Qw9JemRuRmy20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1RWKP3Li/WvkG5CD/vIIjN8HEfxrIY/gFmrG1DEYbWdMgh372dF1nwDcuvYtvLROIQQxvVabN0RZmpp+VVr5TAjJGvXoYfGISrGxhacmRzSG8QNTLA2cR912QlxKr0Y3V7m+o0kwzNfKypYCseH1vIWBKMGwVOkNa15q/WJSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M10by3zb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M10by3zb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45611d82f2eso1338725e9.0
        for <linux-s390@vger.kernel.org>; Fri, 18 Jul 2025 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752872094; x=1753476894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIjz4BPZJqOIM9QQ4fdBf3Y2eXQwrnGfHoI2Y40n68s=;
        b=M10by3zb8RzF1xvJOQkaiotH4Kjf1hLK3OCHTumCxLJEE90k45vu2sJAAABh+MmuDC
         rUKU7blShj9ifETSSU9n8rJtQKchfqFo5QQVWhk60RfD9bWoPPhu3pYVtZ6d60KTq3jj
         1WhBUjKrJRfIa2SwwZ5f4+E140TdbD4Yp5uewVS9nzCSWyPoC+ggrUYpaToxmXiQffeM
         7UqkryOy8DALiwQ0xhNWD6qVYCtFQ2AwiB0XAfq+XUe7wWtVw1wUKGUwHc1Un5HGSTwQ
         cHxgrnT00xWCULm/Ouk7rl0ImZCIKwXGk6Lf12yjRFgdUjg4DeyBVGx9YFhj4VZtu9yd
         e+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752872094; x=1753476894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIjz4BPZJqOIM9QQ4fdBf3Y2eXQwrnGfHoI2Y40n68s=;
        b=spWK4ycvzggY2kt14EFKtNh23sfQshZu2B9GA3Ji1g5YSaA/e0EIz1IDWAVp/StKJx
         JS99oMvFhbuWoC8YeoemUE14askFdXC4IA2RordR8v//IGhhv2RixNsMzA5s3Bi6TDyD
         u+ESEDx/Mfrw5FkbD69heX+fQ1FFVqKaiUIUr3gM9AVEIjqqjM2FsFJF5C1dfKghqpOi
         2gPZjbvqmPR40gqq3SHtoo7oNTK9hqlD3M+TmYB/wUs6XTsj5iN51Ul1SPYDvb5Y7N2/
         SFnuzj0JktUcNEK5g4FO4emgut9zyGOTW7U+QdOn++m89fb1GmAa6JVzEOaDWinlj6u9
         7moA==
X-Forwarded-Encrypted: i=1; AJvYcCWhRXW+C1Td9Jv4DUE74JZq/xmoNqqqDzQgbY2hggBaxFk0g13QBnjocnJXGM0pw1EvdKMn39Jz963m@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lUfEjqo4Ga+tcLO2rucTgbEmi+cmJowbye8T+qfAy5/aacsI
	8GrUjrJOVMOupVwUfjjbAgLYam1lziLXu35QHhvxx+6Zjymz5w22hx4=
X-Gm-Gg: ASbGncsnCw22IdMQwkzbcvinOpam8164K8bpRUn4nvdQnWm90w9H4ZvPD4DsLpKSp6+
	DbkQ/rs3YyCpg6Xc3yO85h5s7dJr8y7w3MmaqD3GrNL4Y1UsCDr/QBll6+PxEGnYz2jKji3EjU5
	659W3Qf3nXp+Jcp1/YNOQXejB/sUtdnME56xNi26MrOJcfgsIzmen5A0p2irkhL3zOAWs+A/6td
	S9Sxhs0sRClin3BapoCWpX/3WjZgdrhBlc+V8ckPAHTh0TrICVWZeSLe0/lEySR8DxSrNhr2GON
	W06LZUxpCr93ndr5QPz4rjU6qQW/+aoyQWnpm7U7JszXnAX97u7gEb6kfcYvhtFaoVTCSIA2Zsp
	C6vocdAnddHYXeQr0Q8PY2IxJgvDU/+LrWtNmKxa0+ANxr5HkSuXD90FCrL4Zo3AFWg==
X-Google-Smtp-Source: AGHT+IFjtNzhZVpFDZWJ7RTeQG+bUKsioxGzYlerosV0A+WYUA92JBe3a3yqDV9rsPpz0H4sieMqNA==
X-Received: by 2002:a05:600c:a218:b0:43b:c825:6cde with SMTP id 5b1f17b1804b1-4562e4fd51dmr30617885e9.3.1752872093235;
        Fri, 18 Jul 2025 13:54:53 -0700 (PDT)
Received: from localhost (179.red-80-39-133.dynamicip.rima-tde.net. [80.39.133.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca31394sm2840353f8f.37.2025.07.18.13.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 13:54:51 -0700 (PDT)
Message-ID: <2c83b76c-46cc-4632-a930-d023c7d3d7b0@gmail.com>
Date: Fri, 18 Jul 2025 22:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] multipath-tools: fix default blacklist of s390 devices
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Nigel Hislop <hislop_nigel@emc.com>,
 Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 Christophe Varoqui <christophe.varoqui@opensvc.com>,
 S390-ML <linux-s390@vger.kernel.org>, DM-DEVEL-ML
 <dm-devel@lists.linux.dev>, Nigel Hislop <hislop_nigel@dell.com>
References: <20250712201454.215404-1-xose.vazquez@gmail.com>
 <76bde3f1-0f06-46fc-8e0a-729e6629024c@gmail.com>
 <d5e08375-211d-405b-9a00-f44c857cedac@linux.ibm.com>
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <d5e08375-211d-405b-9a00-f44c857cedac@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 2:38 PM, Stefan Haberland wrote:

>> Is PAV really supported on FBA devices ???
>> And other than 3390 and 3380(3390 model 2/3 in track-compatibility mode) ECKD types ?
> 
> Currently there is no support in the driver for PAV with FBA devices.
> But the devices itself are capable of PAV.

If there is no PAV support for FBA devices on Linux, and it looks like it won't be
implemented even in the distant future. The detection code, and the device, could
be deleted from multipath-tools:
https://github.com/opensvc/multipath-tools/blob/de16cf82c5263fc148118be56ebf44c8f0ee60b8/libmultipath/hwtable.c#L688-L697
https://github.com/opensvc/multipath-tools/blob/de16cf82c5263fc148118be56ebf44c8f0ee60b8/libmultipath/discovery.c#L1674-L1685

Is PAV supported on 9343/9345 (cutype/devtype) ECKD devices?


Thanks.
