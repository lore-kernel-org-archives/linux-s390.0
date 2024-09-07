Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5F15F3FF
	for <linux-s390@vger.kernel.org>; Sat,  7 Sep 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728227; cv=none; b=Z/orYo6+GYfP+XjWWIMtuz0GBvzVq0kYLcodn45jGfENVhqRvGVF23z7Kxz9q70mg9d7EIWOIOeVL9Snx2WwZA0ZMTbgMU+4+IkpgF+jooki7f4dOlJSZNQactL43JpjF8g8d/udBo6UwqCIVKwCEHOnKrQkULfN9AC7am20A/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728227; c=relaxed/simple;
	bh=ZtMU8w1tloWwxYw7AMQBvYsJJPEwFKU8fUMe+ZaWDOw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qm7RE6HC6ILXzpqb1le6s8LL47AMHwLm3GoMJ1Nk8WeH4o94cMmsKMw0NGFrmNoelriI0AqMANkMG5s2cNtI+iHvBAzu/zDKCL8c7ZXnFpuxMHqcXTM5/ShwwjHQKVUf50ZpaLXl/TWymJE5kgIZ4xH2TfIs8UmBS+g/Rk0m/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f4e119c57so48676525ab.2
        for <linux-s390@vger.kernel.org>; Sat, 07 Sep 2024 09:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725728225; x=1726333025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqioQfI0jRHJ+2HyBzWQTOPsbbuKbvskWBDUXI7NhPA=;
        b=gPGyfB7QJ5OkT0m9e+wJonDMyxm1MwoqlJJZZx1oVDoL/JP6mOfBEkwHZfadIMVX3t
         JLR5MX5ktz4ayxVobP/n+BIm9kLWLPZmKb0dpdINAt58Hfl8GJpupVwWMleYSnv4URl7
         ztXF2Yso2tzTDDHIYNR3POnLN6OU0Go1GdHYMG/v9uAbeDZkt+1s8Dd78aOQCljyniO2
         CqsNd5YVMoBw1HOdvmB6bYKZvC+oddogWsnsjnXxUpamxqAw6WJexRxhpN6N1vUQZwuD
         QfBc1nDC03vCdd96n+vh5stveY16/Eb5asHqYGGxgWjOGoKVfg09Ya6+IUxId7VJpsiB
         9+vw==
X-Forwarded-Encrypted: i=1; AJvYcCVN4VzC6HN6N+82ii530h59G7lOZsCLHs5h41yvE/5NgQMowtABRYHJxz6bb7ngRgg25UYHeu04bnOW@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9stLf0bl0gf/BoNDzmsqJug41+BFDx9MRtuK6LyoUBVWtu7C
	eZX6MFQiM8V6BO/HIFKGOrIxmj1Hg8EBMYF/QW4LZQ7D56sNyq+NofV/p9QOFp6NdVQnVu/OvN3
	7Kx5pB+WxI9KueHarTPKmcQUCZihp03uhspAZuxFOmQsPF90qHwGYV6w=
X-Google-Smtp-Source: AGHT+IF8SgqIXPoeZdJvxIHF/R0WhiGyZdPrZBifF5WpHod7Lg5TLFK+P/zj4no5/G7TG7yVMkfnczv8rs8e36L7Y2XEMzVhfdtl
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3a0:4646:8a7d with SMTP id
 e9e14a558f8ab-3a04f10e30fmr2545425ab.5.1725728224995; Sat, 07 Sep 2024
 09:57:04 -0700 (PDT)
Date: Sat, 07 Sep 2024 09:57:04 -0700
In-Reply-To: <00000000000031c6c50610660f17@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4819606218a69a2@google.com>
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_release
From: syzbot <syzbot+621fd56ba002faba6392@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, aha310510@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, guwen@linux.alibaba.com, 
	jaka@linux.ibm.com, johannes.berg@intel.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	nico.escande@gmail.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b7d7f11a291830fdf69d3301075dd0fb347ced84
Author: Nicolas Escande <nico.escande@gmail.com>
Date:   Tue May 28 14:26:05 2024 +0000

    wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1536189f980000
start commit:   5f76499fb541 tsnep: Add link down PHY loopback support
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ad7bc3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1461e9a7e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
