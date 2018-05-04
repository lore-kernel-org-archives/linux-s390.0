Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 4 May 2018 11:45:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: possible deadlock in smc_close_non_accepted
Message-ID: <20180504034505.GD8958@leo.usersys.redhat.com>
References: <001a114218b2f8c0fe05666a2fb6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a114218b2f8c0fe05666a2fb6@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: syzbot <syzbot+e51e2a7401ab556ffde1@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

#syz fix: net/smc: simplify wait when closing listen socket
