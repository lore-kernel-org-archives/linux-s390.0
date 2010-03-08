From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 08 Mar 2010 13:19:17 +0000
Subject: Re: zfcp_aux.c: strncpy problem
Message-Id: <20100308141917.4d02378f@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <BLU108-W25357E659089FADD57C2F89C350@phx.gbl>
References: <BLU108-W25357E659089FADD57C2F89C350@phx.gbl>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 8 Mar 2010 12:57:51 +0000
d binderman <dcb314@hotmail.com> wrote:

> Hello there Martin,
> 
> > I don't agree with cppcheck:
> >
> > token = strsep(&str, ",");
> > if (!token || strlen(token)>= ZFCP_BUS_ID_SIZE)
> > goto err_out;
> > strncpy(busid, token, ZFCP_BUS_ID_SIZE);
> >
> > strlen(token) < ZFCP_BUS_ID_SIZE which means that the strncpy will
> > copy the terminating zero byte. The code is correct.
> 
> Thanks for pointing this out. Would plain 
> 
> ��� strcpy(busid, token);
> 
> be simpler than the strncpy ?

Yes, that would be simpler. Dunno if it is worth the effort.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
