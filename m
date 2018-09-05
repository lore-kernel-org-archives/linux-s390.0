Return-Path: <linux-mmc-owner@vger.kernel.org>
Subject: Re: [PATCH 01/25] tty: Change return type to void
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
 <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
 <3b5cce6a-b4c3-edf9-51c8-0a16f156e128@cogentembedded.com>
 <CAL6iAaKzDPe7CMGR8VOBZRsJqZuNB1=zek_YVvwcKnjimbox2g@mail.gmail.com>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <d3d5df26-4678-2539-e579-1c48bc726163@suse.cz>
Date: Wed, 5 Sep 2018 07:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAL6iAaKzDPe7CMGR8VOBZRsJqZuNB1=zek_YVvwcKnjimbox2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-mmc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: Jaejoong Kim <climbbb.kim@gmail.com>, sergei.shtylyov@cogentembedded.com
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>, linux-um@lists.infradead.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-bluetooth@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, netdev@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

On 09/05/2018, 03:08 AM, Jaejoong Kim wrote:
>     > @@ -688,7 +688,7 @@ extern int tty_port_close_start(struct
>     tty_port *port,
>     >   extern void tty_port_close_end(struct tty_port *port, struct
>     tty_struct *tty);
>     >   extern void tty_port_close(struct tty_port *port,
>     >                               struct tty_struct *tty, struct file
>     *filp);
>     > -extern int tty_port_install(struct tty_port *port, struct
>     tty_driver *driver,
>     > +extern void tty_port_install(struct tty_port *port, struct
>     tty_driver *driver,
>     >                               struct tty_struct *tty);
> 
>         You need to update all the callers in the same patch -- the
>     kernel must
>     remain buildable after each patch but you seem to have spread that
>     update
>     among a lot of patches..
> 
> 
> OK. I will make several patches as one patch.

You don't have to. Just reorder the patches as suggested by Sam. (First,
make everybody ignore the return value, then change these return types
to void.)

BTW you can mention in this commit log, that this change is possible
after a3123fd0a4a5. That commit made tty_standard_install to always
return 0.

thanks,
-- 
js
suse labs
