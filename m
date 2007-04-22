Return-Path: <linux-kernel-owner+w=401wt.eu-S965052AbXDVGhm@vger.kernel.org>
Message-ID: <653402b90704212337o2ff44140uaa6ab1c893b2bc7f@mail.gmail.com>
Date: Sun, 22 Apr 2007 08:37:40 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: [PATCH 1/8] Kconfig: refine depends statements.
In-Reply-To: <200704220050.24089.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070420113228.GB3738@skybase> <200704220050.24089.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On 4/22/07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I would guess that this actually depends on PARPORT, not PARPORT_PC.
>

In fact it does not depend on any of them. Auxiliary Displays could
use any kind of interface. However, by now we only have one controller
driver (ks0108) through parport (PC); so for the moment the patch
would be OK, although the menu "Auxiliar Displays" is not just about
parport'ed-stuff.

> The rest of this patch looks good.
>
> 	Arnd <><
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
