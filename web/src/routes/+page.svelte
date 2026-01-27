<script lang="ts">
  import type { PageData } from './$types';
  import {
    Card,
    CardContent,
    CardDescription,
    CardFooter,
    CardHeader,
    CardTitle,
  } from "$lib/components/ui/card";
  import { Badge } from "$lib/components/ui/badge";
  import { Button } from "$lib/components/ui/button";

  let { data }: { data: PageData } = $props();
</script>

<div class="container mx-auto py-10 px-4">
  <div class="flex flex-col gap-4 mb-8">
    <h1 class="text-4xl font-bold tracking-tight">Agent Skills</h1>
    <p class="text-muted-foreground text-lg">
      A collection of skills for your AI agents.
    </p>
  </div>

  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    {#each data.skills as skill}
      <Card class="flex flex-col h-full hover:shadow-lg transition-shadow">
        <CardHeader>
          <div class="flex justify-between items-start gap-2">
            <CardTitle class="text-xl">{skill.name}</CardTitle>
            {#if skill.metadata?.version}
              <Badge variant="secondary">v{skill.metadata.version}</Badge>
            {/if}
          </div>
          <CardDescription class="line-clamp-2">
            {skill.description}
          </CardDescription>
        </CardHeader>
        <CardContent class="flex-grow">
          <div class="flex flex-wrap gap-2">
            {#if skill.metadata?.license}
              <Badge variant="outline">{skill.metadata.license}</Badge>
            {/if}
          </div>
        </CardContent>
        <CardFooter>
          <Button href="/skill/{skill.name}" variant="default" class="w-full">
            View Details
          </Button>
        </CardFooter>
      </Card>
    {/each}
  </div>

  {#if data.skills.length === 0}
    <div class="text-center py-20 text-muted-foreground">
      No skills found. Please add skills to the <code>skills/</code> directory.
    </div>
  {/if}
</div>
