Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC030F922
	for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284107; cv=none; b=tM8rJ54ZM61f7prc9WjdEUowJbOvNAIbPiSBKRUhP4KXXzEtWGo3X3ApJmZjD48MAB+4Pmus8YDTKJboeM8B3HHaiqkM6fnQ10N2TPtgxcgbr+mP35wd5KDQjgOuUGir40KohopTg8TowtwOXX3Klmw0/9HTr4Jr6ZMIr86fMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284107; c=relaxed/simple;
	bh=F52Pe6ZzrWg2xOB535H6naWI5/xjhi+X85EvgHGfIVM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XK7cOo252OsWxyAqnWtjSaMwrx0fqgAtBbLgH3jQGic9CH9VAVCiuRVZzMC/14NlA/NKxrvmQJMLdCsH1CXOrtMGnKjjm3jzQSJ4RPDeTBKEkctj/GY7AWcf0Yg/g9TULpb50QpCRVv07f/fIqQBmdRj1vIYxIWF8tUkKkrPc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4241c41110eso44133975ab.1
        for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 05:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284105; x=1758888905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaASq3nSPIcvtUoCKBtRJSEolffSQ27wcU7lwN8Kr/k=;
        b=S3elRIrDh8NYeVdf3LHXnWcET6MHK2lntalrbFzCxkZl9uM9o60jG7/b4UsyiyIzgW
         sF14T6T3M3NCwl1pkQvrzuOOEhc0TlJHA8X18pvwwALSrwEA156kTCJKiXEWythZ+7cZ
         FcnzXWIFlNcQVMqieSatJuO8y4AsMyAgDCtkzc3jYfiHgwqK0+Y8wc644+eLnozSPI9N
         onLZv5qubFk7geeq67c1VMn3aFKkG8u+uCZbIeqYdarH3rqaMaHxgbM/RlNbHiO1K/FK
         3yKN+DOWnsiELEEcKGUh1epIkPt6nMLAzhCwn+gbWwNuoKHYO/ssLmTtqmzhFZPbVqrS
         6fcg==
X-Forwarded-Encrypted: i=1; AJvYcCVrNQHdGUFA077JE92SdOyhD+ALjkvR7wj54dsaGRbhMJnyJPBRnN0rBJ3+MT+ZtXOeDbL6Cyl/9EN+@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtflYjSVNhwa+vFa5wCoFcKsF9+RBCLWbq3C9qSMAvMlFEdxG
	ITFqwdyGWJxpDavdFT+EvpHsmJ3gvT+xQnGhuaIlF5Z28hpCbRkvliDMW8EMy9CHgEKIpx1PWqw
	1OvWxgXlxSK1+4WD72ZM/TVuJ+PXr9w7F/kRbJ9OTTSNWrJT97TS6j6Jg004=
X-Google-Smtp-Source: AGHT+IE1O8Xc6f8LrpO8boudUphXtvq/ClhpDSJmNM3SJDFi102WGVqC7B7iyKEup+Yu/ybdPLc+8ujPyZ6BW73fph6w1dGTVKQY
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378f:b0:414:3168:b9fe with SMTP id
 e9e14a558f8ab-42481991ea9mr59920315ab.29.1758284105478; Fri, 19 Sep 2025
 05:15:05 -0700 (PDT)
Date: Fri, 19 Sep 2025 05:15:05 -0700
In-Reply-To: <68caf6c7.050a0220.2ff435.0597.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd4949.050a0220.ba58e.045c.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	dust.li@linux.alibaba.com, edumazet@google.com, guwen@linux.alibaba.com, 
	horms@kernel.org, jaka@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 98d4435efcbf37801a3246fb53856c4b934a2613
Author: Jeongjun Park <aha310510@gmail.com>
Date:   Thu Aug 29 03:56:48 2024 +0000

    net/smc: prevent NULL pointer dereference in txopt_get

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131dc712580000
start commit:   5aca7966d2a7 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=109dc712580000
console output: https://syzkaller.appspot.com/x/log.txt?x=171dc712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17aec534580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115a9f62580000

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Fixes: 98d4435efcbf ("net/smc: prevent NULL pointer dereference in txopt_get")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
