Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C6149E13
	for <linux-s390@vger.kernel.org>; Sat, 31 May 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748708404; cv=none; b=HfH4pGQG2kA4mD7tmTkNE7eQXCVcmmjU/0HXOxhS8L3mHI79de4kSmfQ+52uZEMsxq9D00uZUlRLG3blMnH4isILIPczTGzWGAp32Vrj5r0gXE8lL8HSZ0g1REHKhEa+jtlaQ/5mTTdLxf8IH/g/jiBxqFCBXnoNW7WYLqbXeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748708404; c=relaxed/simple;
	bh=sgPA9Q230YlwYNsgLsUAGT+EIJ3MJXCV8CkuV+njEC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h++K/4vpIsvYxikqgHRuSKSL0BaOQGLUGXCSsWkLQB3Eiq/92MlvaQXyNMwlvfLdB5/qZiUtnC1q916U6noZAfNnIkjUDcKI2mjjyLRZcVcwOY+JsN7HXhc8/HCfnTKA3WbX/Q8O+ncaNMufKhF6h2MV+yZaWBqhIorK4Thk9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3dd7e0c7195so33758185ab.2
        for <linux-s390@vger.kernel.org>; Sat, 31 May 2025 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748708402; x=1749313202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOT3+3dtKmIMbjiKp4WKPYIYOuy19lzYdhT8ETpxuvo=;
        b=LMmuGwgKKplsCSpTORxRLWOddxCiOFMbtV+LKIhxnSyE8Rt5/HXQW2JF5SnowNVjX7
         UjDLFr27P/VFodvEEfckq4Ep8wU+SvSLztnFGAAWKdxDxdcp6kVUb6v5/VY+AMvcA5tA
         OU9WEPgNpDl+zXKUVRNpDnG93Erwe6a7kivmsph0KY/Su2FFy1u+EyX9FG/IvB59Hr8x
         FJulo5gDtTF7kuTuD9evRb6f99aE54q1bkaITis/cShe1YTzzN1qFpz0jtW9f3QeYJDN
         4Zrl8k0CB2MgAdsuTDblIeYNgB0sDQStgeVQCuwzK8mjVi6QeNNuo84/0f9++627w+96
         KZuw==
X-Forwarded-Encrypted: i=1; AJvYcCXxiah2Wjontd2DqvtT0r9WZxqu69m02oZUkxN+ForInXNAi80vlO1r5hfTUFQY0H7gufYc53juwaV6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8Q+BPY3xkRWROSfKB81Kul5ptQnC3BsR2kkpuj8Tyefih24x
	kMaClK2cqs7mt+L8KWsosWIJE+74cFaIgN14y1RUKeXzipdxzLnXsga2Dgl1w7Y7gwVWuh9+y7N
	PMxR+TFlBSgH9It3Q5x4YpcX+Ml61HvXo+2w59FvxE5IM64Ia40hSdO09t2c=
X-Google-Smtp-Source: AGHT+IGdap3ueor/+dC4QVfuI3dEjhxnuRezgHUx4IFWYUjshQSu+2Ssy2m7Z8B44GaIOMUzHwVmDX58Z5+KnBdSnlu+zMS+qDxq
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3dd:8a06:4db3 with SMTP id
 e9e14a558f8ab-3dda339232emr19169295ab.19.1748708401944; Sat, 31 May 2025
 09:20:01 -0700 (PDT)
Date: Sat, 31 May 2025 09:20:01 -0700
In-Reply-To: <000000000000ec1f6b061ba43f7d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683b2c31.a00a0220.d8eae.001b.GAE@google.com>
Subject: Re: [syzbot] [smc?] possible deadlock in smc_switch_to_fallback (2)
From: syzbot <syzbot+bef85a6996d1737c1a2f@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 752e2217d789be2c6a6ac66554b981cd71cd9f31
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Apr 7 17:03:17 2025 +0000

    smc: Fix lockdep false-positive for IPPROTO_SMC.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13833ed4580000
start commit:   47e55e4b410f openvswitch: fix lockup on tx to unregisterin..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14832cb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e17218580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: smc: Fix lockdep false-positive for IPPROTO_SMC.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
