Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422E8EEB560
	for <linux-s390@archiver.kernel.org>; Fri,  8 Sep 2023 18:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjIHSm5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 8 Sep 2023 14:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjIHSm4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Sep 2023 14:42:56 -0400
Received: from mail-qt1-x845.google.com (mail-qt1-x845.google.com [IPv6:2607:f8b0:4864:20::845])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D871716
        for <linux-s390@vger.kernel.org>; Fri,  8 Sep 2023 11:42:19 -0700 (PDT)
Received: by mail-qt1-x845.google.com with SMTP id d75a77b69052e-414c96b2ecaso27337131cf.0
        for <linux-s390@vger.kernel.org>; Fri, 08 Sep 2023 11:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694198157; x=1694802957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lAvPiHpQzYJH2/Evbqeae0jEIobBXd5mkIT/JR5mjU=;
        b=w2qgVCo8cytwJ8FTdoSt8+RYVgPfCAUWJ5Yh7hXj5TEA8BlmFbkzzf/MeIhW1MVCkI
         o6nGS2srlGXze0gLdTiI/3pXpU+4xWQ8M+uccphMgDR6gaDuR25gBT1zHaJ8xbheSw32
         OCe8VmFtK7+gg39rmv19gyoDd0AnwY3UV+fAwdTGA3NJPqjnUhjKIX7RgKB9AQomowaA
         Sc8ETCs76R6Uv4F28sXobCrjE8dUZ7vlOjrcG9brSqmsSLl3/tfJ8GhA8ZxEt+5ecI6D
         28T86RcLPDgddz6aLgLcNWOR1mlnDop0ZTbvrzwtlE3NzN1w+vOLDhRDA5tkY9KEZPW5
         +jVg==
X-Gm-Message-State: AOJu0YyzNSpwnq9uT69vPUV3bS4NX7nQftad3VuaiTu9uO66OxxoMc7R
        sjlk1/YiOTp6t5jPre9hW6/o6pm1vi7CyPa41Qsz5agnSrsk
X-Google-Smtp-Source: AGHT+IFG6oZqBOayFovKE0NVKEQ0Xnwtd+Nskzg2qKPXIoko6vfMv+elInHkBKWJh6QlQckbllDdPD2ESA+Mlnx+N1cgB86kBYBd
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:80c:b0:68a:3c7a:128c with SMTP id
 m12-20020a056a00080c00b0068a3c7a128cmr1357477pfk.2.1694196270440; Fri, 08 Sep
 2023 11:04:30 -0700 (PDT)
Date:   Fri, 08 Sep 2023 11:04:30 -0700
In-Reply-To: <000000000000f392a60604a65085@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e127ec0604dcce27@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
From:   syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>
To:     42.hyeyoo@gmail.com, Liam.Howlett@Oracle.com,
        agordeev@linux.ibm.com, akpm@linux-foundation.org,
        alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
        borntraeger@linux.ibm.com, cgroups@vger.kernel.org,
        christophe.leroy@csgroup.eu, damon@lists.linux.dev,
        david@redhat.com, eadavis@sina.com, frankja@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        hannes@cmpxchg.org, hca@linux.ibm.com, imbrenda@linux.ibm.com,
        jeeheng.sia@starfivetech.com, jglisse@redhat.com,
        kvm@vger.kernel.org, leyfoon.tan@starfivetech.com,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mason.huo@starfivetech.com,
        mhocko@kernel.org, mpe@ellerman.id.au, muchun.song@linux.dev,
        naoya.horiguchi@nec.com, npiggin@gmail.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, roman.gushchin@linux.dev,
        sebastian.reichel@collabora.com, shakeelb@google.com,
        sj@kernel.org, surenb@google.com, svens@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

syzbot has bisected this issue to:

commit 49b0638502da097c15d46cd4e871dbaa022caf7c
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Fri Aug 4 15:27:19 2023 +0000

    mm: enable page walking API to lock vmas during the walk

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fd2348680000
start commit:   7733171926cc Merge tag 'mailbox-v6.6' of git://git.linaro...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fd2348680000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd2348680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4ecd0680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1055c284680000

Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
Fixes: 49b0638502da ("mm: enable page walking API to lock vmas during the walk")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
