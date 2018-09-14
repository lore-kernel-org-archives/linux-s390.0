Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 14 Sep 2018 07:37:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for 4.19 #3
In-Reply-To: <CA+55aFxYR__1rfT--Vxkoh1RyA+g6pQs87H8tk7ajXW9L8p7tg@mail.gmail.com>
References: <20180913140149.3c39485c@mschwideX1>
        <CA+55aFxYR__1rfT--Vxkoh1RyA+g6pQs87H8tk7ajXW9L8p7tg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20180914073756.2c208e55@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 13 Sep 2018 16:26:38 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Sep 13, 2018 at 2:02 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > this is the first try to do a pull request for s390 with a signed tag.
> > I keep my fingers crossed that the setup works as intended.
> >
> > I have used the 8A8FDAE0 signing sub-key of my 26AE5DD2 master key:  
> 
> The signed tag looks ok, but you haven't actually pushed out your new
> signing sub-key to the keyservers, so I can't actually verify it.
> 
> So a "gpg --send-key" would be a good idea.

I did push it to keys.gnupg.net, but the sub-key is brand new and 
probably takes some time to sync on the key server network.

The key is there on pgp.mit.edu this morning, it that to one you
are using or do you prefer a different one?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
