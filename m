Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F131F4621
	for <linux-s390@vger.kernel.org>; Sat, 20 Sep 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758343028; cv=none; b=oHC/9QAY3CPWLfECFpa91TZVLysUMOw48M7a/LbhK7pCBKTXIGfG7Va/HtVcM5XXUjb+U6cTm4TQEZgXgXERgZznyPmu4Y0RuTMeRlrHiqfbbXy/NdTbQS3OutfVqn3c2Ugmgjkm+syqJiAQXk/LAXou1pwl01/sYaatwRt2oBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758343028; c=relaxed/simple;
	bh=eLZJJ4b5Hv13WnuF/je/2Gc/GJOLCP6cLSLyncvNLdA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H7BjjeyxdmsP7H2oJhnGh5ab0F/7/rO4DJaHemkwKfDBa/DV4a0J0Coa3Jb0wtd1lTZDSLOTCJhcsMcRaQ/MgvAvKt7j3g1fRkPDy/x1EjXNXyqy5br5K/nUgVXntpzqFr8iJoHe3ana0atmZK/kulFkqoHJhds3hbhfHXFun60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8870219dce3so297031139f.0
        for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 21:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758343026; x=1758947826;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gja0G+YNMT4nfkxekGzUizab20nltKnqLeo3HZHwrLU=;
        b=b/x43UlYS63t7TxvpsNubgiv1qzoyFd6LnjrK+8wjW48Wa9rVfT5NxV0P8Qyub8yBq
         cC9SqJBNU9rkrctKRpuClA6NCOIYWvMevsSXtCv1RVBci9BszOsa+p2q1XAYOaQMmwqd
         fHMGjmJu+bjrBjKbBmTMVwGOXYgXe1S2HushNPzn6RPj3+Q1H3Ma4yfiepA0sxfCVqBt
         ZGGzLOelVau7ynyFtUyXmpLQch4GHZ8GUFZynEDAZEXzhc/ACBuITl/fU61dATdZoCsL
         iJIiScJywnuWPDHIv7eYPmNZJf1pzyO5EbBbqNJ9Uo4QymkBdJKHd5o+m4hjoTeTNF3V
         B6uw==
X-Forwarded-Encrypted: i=1; AJvYcCUv+fA8YhDhcvgTHCZAvRaYCLTlQTPL5c/tXInP2F4p/dKAwAmGgkKtXLCs+sV7iQaz6wlP0sSwD9ll@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5EzOH6qCdyoucgQbSnQxvVBLJ2KcZ5Oj91J/rAKU7Ci6NPrr
	ZVCNgzkG4FtESyYcEE3Pli0PW9kilWNWXCHz415oDrYvg5WlmrDUX4+Zn0tWvyNanelys1yXJxM
	QiG8FPRbL3gH5+eZ2o8JxP30KCcs8WCxDBhPmLjb/X5j06pVan+yczEENFrc=
X-Google-Smtp-Source: AGHT+IEboJPHmu/GmGIV1HX2yNQ77XkVwCngjKU9vicDDz+MZ7u0oRXuv26/XZA4q8RUdEr6/vmWleC4YNydH6JYZXyh1b78jOd3
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:424:2d4:585e with SMTP id
 e9e14a558f8ab-424818f920bmr87191575ab.1.1758343026440; Fri, 19 Sep 2025
 21:37:06 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:37:06 -0700
In-Reply-To: <0ca2c567-b311-4f0b-bb29-2b860b75f85e@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce2f72.050a0220.13cd81.000f.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wangliang74@huawei.com, wenjia@linux.ibm.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/smc/smc.h
Hunk #1 FAILED at 285.
1 out of 1 hunk FAILED



Tested on:

commit:         cd89d487 Merge tag '6.17-rc6-smb3-client-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1381a0e2580000

